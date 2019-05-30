#####################################################################################
#
# Rules:
# 1) do not modify the conda base environment python packages
# 2) use scripts to install enviroments and packages
# 3) install system packages with conda (for portability outside of docker)
#
#####################################################################################

FROM jupyter/scipy-notebook

MAINTAINER "Todd Valentic" <todd.valentic@sri.com>


# Create cache directories and prepare for building
USER $NB_USER 

ENV BUILD $HOME/build
ENV MPLBACKEND Agg

RUN mkdir -p $HOME/cache/omni && \
    mkdir -p $HOME/cache/ssies && \
    mkdir -p $HOME/examples && \
    mkdir -p $BUILD 

WORKDIR /home/$NB_USER/build 


# Do root user stuffs: install OS packages, install other packages
USER root

# OS packages that make working easier
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    mlocate \
    less \
    vim

# custom scripts
COPY resources/start-singleuser-ingeo.sh /usr/local/bin
COPY resources/nbstripout /usr/local/bin

# Install NASA CDF from source
COPY resources/helpers/install_CDF.sh .
COPY resources/cdf.sh /etc/profile.d
# the following is needed so that CDF_LIB is defined even if we use bash without logging in
RUN /bin/bash -c 'bash install_CDF.sh && \
                  echo "if [ -z \$CDF_LIB ]; then source /usr/local/bin/definitions.B; fi" >>  /home/jovyan/.bashrc'
RUN /bin/bash -c 'rm install_CDF.sh'

# Ok, now do user stuff
USER $NB_USER

# Move conda's envs directory into user home directory
# might make things easier from a persistence point of view
RUN /bin/bash -cl 'mkdir ~/envs && rm -rf /opt/conda/envs && ln -s ~/envs /opt/conda/envs'

# Update conda and pip
RUN /bin/bash -cl 'conda install -y -n base conda==4.6.11'
RUN /bin/bash -cl 'conda init'
RUN /bin/bash -cl 'pip install -U pip==19.0.3'

# Set up Conda environments
# python2.7
COPY resources/helpers/setup_py27_env.sh .
RUN /bin/bash -cl 'bash setup_py27_env.sh && rm setup_py27_env.sh'

# python3.6
COPY resources/helpers/setup_py36_env.sh .
RUN /bin/bash -cl 'bash setup_py36_env.sh && rm setup_py36_env.sh'

# register environments with Jupyter
RUN /bin/bash -cl 'source /opt/conda/etc/profile.d/conda.sh && \
                   conda activate py27 && \
                   pip install ipykernel && \
                   python -m ipykernel install --user --name py27 --display-name "py27" && \
                   conda activate py36 && \
                   pip install ipykernel && \
                   python -m ipykernel install --user --name py36 --display-name "py36"'

# install basemap v1.2.0rel
COPY resources/helpers/setup_basemap.sh .
RUN /bin/bash -cl 'bash setup_basemap.sh && rm setup_basemap.sh'

# install davitpy 0.8-master
COPY resources/helpers/setup_davitpy.sh .
RUN /bin/bash -cl 'bash setup_davitpy.sh && rm setup_davitpy.sh'
# set davitpy environment variables
ENV SD_HDWPATH=$HOME/cache/hdw.dat
ENV SD_RADAR=$HOME/cache/radar.dat



# install spacepy 0.1.6
COPY resources/helpers/setup_spacepy.sh .
RUN /bin/bash -cl 'bash setup_spacepy.sh && rm setup_spacepy.sh'

# DataFetcher python package and example notebook
COPY resources/FetchingDataFromManifest.ipynb /home/$NB_USER/examples
COPY resources/test_manifest.json /home/$NB_USER/examples
COPY resources/FetchData.tar.gz $PWD
RUN /bin/bash -c 'tar -zxf FetchData.tar.gz && \
                  source /opt/conda/etc/profile.d/conda.sh && \
                  conda activate py27 && \
                  pip install ./FetchData --no-deps'


# post installation stuff
# cleanup
WORKDIR /home/$NB_USER/work
RUN /bin/bash -c 'rm -r $BUILD && rm /home/$NB_USER/.wget-hsts'

# password-less login on jupyterhub when running locally.
RUN /bin/bash -c 'source /opt/conda/etc/profile.d/conda.sh && \
                  conda activate py36 && \
                  pip install jupyterlab jupyterhub-dummyauthenticator'

# NB_USER doesn't have root access, so move the mlocate database
RUN /bin/bash -c 'echo "alias updatedb=\"/usr/bin/updatedb --require-visibility 0 -o ~/.locate.db\"" >>  ~/.bashrc && \
    echo "alias locate=\"/usr/bin/locate -d ~/.locate.db\"" >>  ~/.bashrc && \
    /usr/bin/updatedb --require-visibility 0 -o ~/.locate.db'
