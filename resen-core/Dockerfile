FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update --fix-missing -y

ENV LANG=C.UTF-8

# Install packages
RUN apt-get install -y --no-install-recommends apt-utils curl \
    build-essential \
    autoconf libtool pkg-config \
    vim zip unzip\
    bash-completion \
    gfortran \
    git wget rsync

RUN apt-get install -y --no-install-recommends python2.7 \
    python3.6 python3-virtualenv \
    python-setuptools python3-setuptools \
    python3-numpy \
    python-dev python3-dev \
    libproj-dev proj-data proj-bin \
    libgeos++-dev libgeos-dev \
    libdb-dev \
    python3-tk python-tk


#RUN apt-get install -y --no-install-recommends python2.7 \
#    python-setuptools python3-setuptools \
#    python-pip python3-pip \
#    python-dev python3-dev \
#    python3-numpy \
#    libproj-dev proj-data proj-bin \
#    libgeos++-dev libgeos-dev \
#    libdb-dev \
#    python3-tk python-tk
#

LABEL maintainer="Pablo Reyes <pablo.reyes@sri.com>"
ARG NB_USER="jovyan"
ARG NB_UID="1000"
ARG NB_GID="100"
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

USER $NB_USER
ENV TERM=xterm-256color 
ENV SHELL=/bin/bash
RUN /bin/bash -c 'mkdir /home/$NB_USER/envs && \
        python3 -m virtualenv -p /usr/bin/python3.6 /home/$NB_USER/envs/py36 && \
        python3 -m virtualenv -p /usr/bin/python2.7 /home/$NB_USER/envs/py27'

ARG BUILD=/home/$NB_USER/build
RUN mkdir -p $BUILD
WORKDIR $BUILD

COPY resources/helpers/setup_py36_env.sh .
RUN /bin/bash -c 'bash setup_py36_env.sh && rm setup_py36_env.sh'

COPY resources/helpers/setup_py27_env.sh .
RUN /bin/bash -c 'bash setup_py27_env.sh && rm setup_py27_env.sh'

USER root
# NASA CDF library
# dependency:
RUN apt-get install -y libncurses5-dev
USER $NB_USER
COPY resources/helpers/install_CDF.sh .
COPY resources/cdf.sh /etc/profile.d
RUN /bin/bash -c 'bash install_CDF.sh && \
    echo "if [ -z \$CDF_LIB ]; then source /usr/local/bin/definitions.B; fi" >> /home/$NB_USER/.bashrc'
RUN /bin/bash -c 'rm install_CDF.sh'

# now user stuff

COPY resources/helpers/setup_basemap.sh .
RUN /bin/bash -c 'bash setup_basemap.sh && rm setup_basemap.sh'

# only for python2.7 :
COPY resources/helpers/setup_davitpy.sh .
RUN /bin/bash -c 'bash setup_davitpy.sh && rm setup_davitpy.sh'
ENV SD_HDWPATH=/home/$NB_USER/cache/hdw.dat
ENV SD_RADAR=/home/$NB_USER/cache/radar.dat

# install mangopy
COPY resources/helpers/setup_mangopy.sh .
RUN /bin/bash -cl 'bash setup_mangopy.sh && rm setup_mangopy.sh'

COPY resources/helpers/setup_spacepy.sh .
RUN /bin/bash -c 'bash setup_spacepy.sh && rm setup_spacepy.sh'

# install pyglow
COPY resources/helpers/setup_pyglow.sh .
RUN /bin/bash -cl 'bash setup_pyglow.sh && rm setup_pyglow.sh'

RUN mkdir /home/$NB_USER/work
WORKDIR /home/$NB_USER

# Configuration of Jupiter lab/notebook user interface
# activate by default py36 in the terminal:
RUN /bin/bash -c 'echo "source /home/$NB_USER/envs/py36/bin/activate " >> /home/$NB_USER/.bashrc'
# To avoid error: OSError: [Errno 99] Cannot assign requested address
RUN /bin/bash -c 'printf "c.NotebookApp.ip = \"0.0.0.0\" \n" >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py'
RUN /bin/bash -c 'source /home/$NB_USER/envs/py36/bin/activate && \
                  yes | jupyter kernelspec remove python3'
RUN /bin/bash -c 'printf "c.KernelSpecManager.ensure_native_kernel = False\n" >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py'

USER root
# Remove apt cache to make the image smaller
RUN rm -rf /var/lib/apt/lists/*
RUN /bin/bash -c 'rm -rf /home/$NB_USER/build && rm -rf /home/$NB_USER/.wget-hsts'

USER $NB_USER

