FROM earthcubeingeo/resen-base:2020.2.0

LABEL maintainer="Ingeo Team <ingeo-team@ingeo.datatransport.org>"
LABEL description="The core docker image used by resen."

ARG NB_USER="jovyan"

#---------------------------------------------------
# Install resen-core specific stuff like python
# packages, other software, etc.
#---------------------------------------------------

USER root

# Install some system utilities
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    less vim zip \
    curl \
    autoconf libtool pkg-config \
    bash-completion \
    gfortran \
    rsync \
    mlocate && \
    rm -rf /var/lib/apt/lists/*

# Install python stuff
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    python3-virtualenv \
    python3-setuptools \
    python3-dev \
    python3.8 \
    libproj-dev proj-data proj-bin \
    libgeos++-dev libgeos-dev \
    libdb-dev \
    python3-tk && \
    rm -rf /var/lib/apt/lists/*

# Install system libraries needed by python packages
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    libncurses5-dev \
    cm-super && \
    rm -rf /var/lib/apt/lists/*

# Create python 3.8 virtual environment
USER $NB_USER
RUN /bin/bash -c 'mkdir -p /home/$NB_USER/envs && \
        python3 -m virtualenv -p /usr/bin/python3.8 /home/$NB_USER/envs/py38'

WORKDIR /home/$NB_USER

# Install the NASA CDF library
USER root
COPY resources/helpers/install_CDF.sh .
COPY resources/cdf.sh /etc/profile.d
RUN /bin/bash -c 'bash install_CDF.sh && rm install_CDF.sh'


# Now install all python packages
USER $NB_USER

COPY resources/helpers/setup_py38_env.sh .
RUN /bin/bash -cl 'source /home/$NB_USER/envs/py38/bin/activate && bash setup_py38_env.sh && rm setup_py38_env.sh'

# register python environments with ipykernel

RUN /bin/bash -c 'source /home/$NB_USER/envs/py38/bin/activate && \
                  pip install ipykernel==5.1.1 && \
                  python -m ipykernel install --user --name py38 --display-name "py38"'

# remove python3 kernel from showing up in jupyter
RUN /bin/bash -cl 'source /home/$NB_USER/envs/py38/bin/activate && \
                   yes | jupyter kernelspec remove python3'

# Install basemap
COPY resources/helpers/setup_basemap.sh .
RUN /bin/bash -c 'bash setup_basemap.sh && rm setup_basemap.sh'

# Install pyglow
COPY resources/helpers/setup_pyglow.sh .
RUN /bin/bash -cl 'bash setup_pyglow.sh && rm setup_pyglow.sh'

# Install citationhelper
USER root
COPY resources/pkg_citations.json /home/$NB_USER/cache/
RUN chown -R $NB_USER:users "/home/$NB_USER/cache/"
USER $NB_USER

# create work directory for user
RUN mkdir /home/$NB_USER/work

# set default python environment to py38
RUN /bin/bash -c 'echo "source /home/$NB_USER/envs/py38/bin/activate" >> /home/$NB_USER/.bashrc'

# post installation stuff
# Download 110m scale cartopy data
COPY resources/feature_download.py .
RUN /bin/bash -cl 'source /home/$NB_USER/envs/py38/bin/activate && \
                   python feature_download.py physical cultural cultural-extra --do_scales 110m && \
                   rm feature_download.py'

# Finally set up some stuff to make user experience better
RUN echo "TERM=xterm-256color" >> /home/$NB_USER/.bashrc && \
    echo "MPLBACKEND=Agg" >> /home/$NB_USER/.bashrc && \
    echo "export CITEHELP_REFFILE=/home/$NB_USER/cache/pkg_citations.json" >> /home/$NB_USER/.bashrc

# Set default jupyter terminal shell
RUN /bin/bash -cl 'source /home/$NB_USER/envs/py38/bin/activate && \
                   jupyter-lab --generate-config'
RUN sed -i -e 's/# c.ServerApp.terminado_settings = {}/c.ServerApp.terminado_settings = {\"shell_command\"\:[\"\/bin\/bash\"]}/' /home/jovyan/.jupyter/jupyter_lab_config.py
# needed so jupyterhub on the demo server starts things up properly (uses jupyterhub-singleuser) as of jupyterhub==1.1.0.
RUN echo 'c.NotebookApp.terminado_settings = {"shell_command":["/bin/bash"]}' > /home/jovyan/.jupyter/jupyter_notebook_config.py

# Set the jupyterlab user-settings
RUN /bin/bash -cl 'mkdir -p /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension && \
                 echo  "{\"disclaimed\": false,\"enabled\":false}" > /home/jovyan/.jupyter/lab/user-settings/@jupyterlab/extensionmanager-extension/plugin.jupyterlab-settings'
