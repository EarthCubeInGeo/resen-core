FROM ubuntu:18.04

LABEL maintainer="Ingeo Team <ingeo-team@ingeo.datatransport.org>"
LABEL description="The core docker image used by resen."

#--------------------------------------------------
# First, make sure we have some of the things that
# jupyter/scipy-notebook has in it
#--------------------------------------------------
# stuff from jupyter/base-notebook

ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"

USER root

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    sudo \
    locales \
    fonts-liberation \
    run-one

# install tini
ARG TINI_VERSION="v0.18.0"
RUN cd /usr/local/bin && \
    wget https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini && \
    chmod +x /usr/local/bin/tini

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen
    # echo "LANG=C.UTF-8" >> /etc/

# Add a script that we will use to correct permissions after running certain commands
ADD jupyter/fix-permissions /usr/local/bin/fix-permissions
RUN chmod +x /usr/local/bin/fix-permissions

# Enable prompt color in the skeleton .bashrc before creating the default NB_USER
RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc

# Create NB_USER wtih name jovyan user with UID=1000 and in the 'users' group
# and make sure these dirs are writable by the `users` group.
RUN echo "auth requisite pam_deny.so" >> /etc/pam.d/su && \
    sed -i.bak -e 's/^%admin/#%admin/' /etc/sudoers && \
    sed -i.bak -e 's/^%sudo/#%sudo/' /etc/sudoers && \
    useradd -m -s /bin/bash -N -u $NB_UID $NB_USER && \
    chmod g+w /etc/passwd && \
    fix-permissions $HOME

# Configure container startup
ENTRYPOINT ["tini", "-g", "--"]
CMD ["start-notebook.sh"]

# Set up system environment variables
COPY resources/02-resen.sh /etc/profile.d/

# Add scripts for starting servers
COPY jupyter/start.sh /usr/local/bin/
COPY jupyter/start-notebook.sh /usr/local/bin/
COPY jupyter/start-singleuser.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh && \
    chmod +x /usr/local/bin/start-notebook.sh && \
    chmod +x /usr/local/bin/start-singleuser.sh

#COPY jupyter/jupyter_notebook_config.py /etc/jupyter/

# Fix permissions on /etc/jupyter as root
#RUN fix-permissions /etc/jupyter/

#stuff from jupyter/scipy-notebook
RUN apt-get update && apt-get install -yq --no-install-recommends \
    build-essential \
    emacs \
    git \
    inkscape \
    jed \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    netcat \
    pandoc \
    python-dev \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-xetex \
    tzdata \
    unzip \
    nano

#---------------------------------------------------
# Now we can install resen-core specific stuff like
# python packages, other software, etc.
#---------------------------------------------------

# Install some system utilities
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    less vim zip \
    curl \
    autoconf libtool pkg-config \
    bash-completion \
    gfortran \
    rsync \
    mlocate

# Install python stuff
RUN apt-get install -yq --no-install-recommends \
    python2.7 python3.6 \
    python-virtualenv python3-virtualenv \
    python-setuptools python3-setuptools \
    python-dev python3-dev \
    libproj-dev proj-data proj-bin \
    libgeos++-dev libgeos-dev \
    libdb-dev \
    python-tk python3-tk

# Install system libraries needed by python packages
RUN apt-get install -yq --no-install-recommends \
    libncurses5-dev

# Create python 2.7 and python 3.6 virtual environments
USER $NB_USER
RUN /bin/bash -c 'mkdir -p /home/$NB_USER/envs && \
        python3 -m virtualenv -p /usr/bin/python3.6 /home/$NB_USER/envs/py36 && \
        python3 -m virtualenv -p /usr/bin/python2.7 /home/$NB_USER/envs/py27'

# set up a build directory
ARG BUILD=/home/$NB_USER/build
RUN mkdir -p $BUILD
WORKDIR $BUILD


# Install the NASA CDF library
USER root
COPY resources/helpers/install_CDF.sh .
COPY resources/cdf.sh /etc/profile.d
# RUN /bin/bash -c 'bash install_CDF.sh && \
#     echo "if [ -z \$CDF_LIB ]; then source /usr/local/bin/definitions.B; fi" >> /home/$NB_USER/.bashrc'
# RUN /bin/bash -c 'rm install_CDF.sh'
RUN /bin/bash -c 'bash install_CDF.sh && rm install_CDF.sh'


# Now install all python packages
USER $NB_USER

COPY resources/helpers/setup_py36_env.sh .
RUN /bin/bash -cl 'source /home/$NB_USER/envs/py36/bin/activate && bash setup_py36_env.sh && rm setup_py36_env.sh'

COPY resources/helpers/setup_py27_env.sh .
RUN /bin/bash -cl 'source /home/$NB_USER/envs/py27/bin/activate && bash setup_py27_env.sh && rm setup_py27_env.sh'

# register python environments with ipykernel
RUN /bin/bash -cl 'source /home/$NB_USER/envs/py27/bin/activate && \
                   pip install ipykernel==4.10.0 && \
                   python -m ipykernel install --user --name py27 --display-name "py27" && \
                   source /home/$NB_USER/envs/py36/bin/activate && \
                   pip install ipykernel==5.1.1 && \
                   python -m ipykernel install --user --name py36 --display-name "py36"'

COPY resources/helpers/setup_basemap.sh .
RUN /bin/bash -c 'bash setup_basemap.sh && rm setup_basemap.sh'

# Install davitpy (only works on python2.7):
COPY resources/helpers/setup_davitpy.sh .
RUN /bin/bash -c 'bash setup_davitpy.sh && rm setup_davitpy.sh'
# RUN /bin/bash -c 'bash setup_davitpy.sh && rm setup_davitpy.sh && \
#                   echo "SD_HDWPATH=/home/$NB_USER/cache/hdw.dat" >> /home/$NB_USER/.bashrc && \
#                   echo "SD_RADAR=/home/$NB_USER/cache/radar.dat" >> /home/$NB_USER/.bashrc'

# Install spacepy
#COPY resources/helpers/setup_spacepy.sh .
#RUN /bin/bash -cl 'bash setup_spacepy.sh && rm setup_spacepy.sh'

# Install pyglow
COPY resources/helpers/setup_pyglow.sh .
RUN /bin/bash -cl 'bash setup_pyglow.sh && rm setup_pyglow.sh'

# create work directory for user
RUN mkdir /home/$NB_USER/work

# set default python environment to py36
RUN /bin/bash -c 'echo "source /home/$NB_USER/envs/py36/bin/activate" >> /home/$NB_USER/.bashrc'
# To avoid error: OSError: [Errno 99] Cannot assign requested address
#RUN /bin/bash -c 'printf "c.NotebookApp.ip = \"0.0.0.0\" \n" >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py'

# remove python3 kernel from showing up in jupyter
RUN /bin/bash -c 'source /home/$NB_USER/envs/py36/bin/activate && \
                  yes | jupyter kernelspec remove python3'
#RUN /bin/bash -c 'printf "c.KernelSpecManager.ensure_native_kernel = False\n" >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py'

# post installation stuff
# cleanup
WORKDIR /home/$NB_USER
USER root
RUN rm -r $BUILD && \
    rm /home/$NB_USER/.wget-hsts && \
    rm -rf /var/lib/apt/lists/*

# RUN echo "SHELL=/bin/bash" >> /etc/environment

USER $NB_USER
# Download 110m scale cartopy data
COPY resources/feature_download.py .
RUN /bin/bash -cl 'source /home/$NB_USER/envs/py36/bin/activate && \
                   python feature_download.py physical cultural cultural-extra --do_scales 110m && \
                   rm feature_download.py'

# # patch jupyter notebook server (until https://github.com/jupyter/notebook/pull/4674 is merged and released)
# COPY resources/notebookapp.patch .
# RUN /bin/bash -cl 'patch /home/jovyan/envs/py36/lib/python3.6/site-packages/notebook/notebookapp.py notebookapp.patch && rm notebookapp.patch'

# Finally set up some stuff to make user experience better
RUN echo "TERM=xterm-256color" >> /home/$NB_USER/.bashrc && \
    # echo "SHELL=/bin/bash" >> /home/$NB_USER/.bashrc && \
    echo "MPLBACKEND=Agg" >> /home/$NB_USER/.bashrc
