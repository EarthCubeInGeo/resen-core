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

# Create cache directories 

USER $NB_USER 

ENV BUILD $HOME/build
ENV MPLBACKEND Agg

RUN mkdir -p $HOME/cache/omni && \
    mkdir -p $HOME/cache/ssies && \
    mkdir -p $HOME/examples && \
    mkdir -p $BUILD 

WORKDIR /home/$NB_USER/build 

#######################################################################################
# DO ROOT USER STUFF, SUCH AS INSTALLING PACKAGES
#######################################################################################
USER root

# Install OS packages that make working easier (tools like vim, etc)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    mlocate \
    less \
    vim


#    libhdf5-serial-dev \
#    libfreetype6-dev \
#    libpng-dev \
#    libffi-dev \
#    libssl-dev \
#    libnetcdf-dev \
#    ncurses-dev \
#    g++ \
#    python-bsddb3             # needed for sciunit2... or can get with conda

#############################
# Copy in some custom scripts
#############################
COPY resources/start-singleuser-ingeo.sh /usr/local/bin
COPY resources/nbstripout /usr/local/bin

##############################
# Install NASA CDF from source
##############################
COPY resources/helpers/install_CDF.sh .
RUN chmod +x install_CDF.sh && ./install_CDF.sh
RUN rm install_CDF.sh
RUN rm /home/jovyan/.wget-hsts
COPY resources/cdf.sh /etc/profile.d

#######################################################################################
# DO USER STUFF, SUCH AS INSTALL PYTHON PACKAGES
#######################################################################################

USER $NB_USER

########################################################
# Move Conda's envs directory into user home directory
# Easier for persistence of changes to environment
########################################################
RUN mkdir ~/envs && rm -rf /opt/conda/envs && ln -s ~/envs /opt/conda/envs

###############
# Update Conda 
###############
RUN conda install -y -n base conda==4.6.8

###########################################
# Install packages with binaries from Conda
###########################################
conda install --yes -n base -c anaconda gcc_linux-64==7.3.0 gfortran_linux-64==7.3.0 gxx_linux-64==7.3.0 # only for linux
conda install --yes -n base -c anaconda db==5.3.28  # needed for sciunit2
conda install --yes -n base -c conda-forge mpich==3.2.1 hdf5==1.10.1 # only osx and linux
conda install --yes -n base -c anaconda libpng-devel-cos6-x86_64==1.2.49 freetype==2.9.1 openssl==1.1.1 libnetcdf==4.6.1 libffi==3.2.1 ncurses==6.1 

############################
# Set up Conda environments
############################

# python2.7
COPY resources/helpers/setup_py27_env.sh .
RUN chmod +x setup_py27_env.sh && ./setup_py27_env.sh
RUN rm setup_py27_env.sh

# python3.6
COPY resources/helpers/setup_py36_env.sh .
RUN chmod +x setup_py36_env.sh && ./setup_py36_env.sh
RUN rm setup_py36_env.sh

############################
# Install davitpy 0.8-master
############################
COPY resources/helpers/setup_davitpy.sh .
RUN chmod +x setup_davitpy.sh && ./setup_davitpy.sh
RUN rm setup_davitpy.sh

#################
# Install spacepy
#################
COPY resources/helpers/setup_spacepy.sh .
RUN chmod +x setup_spacepy.sh && ./setup_spacepy.sh
RUN rm setup_spacepy.sh

#################
# Install pyglow
#################

#################
# Install sunpy
#################

#################
# Install heliopy
#################



#############################################
# BROKEN, SO REMOVED FOR NOW Install amiepy
#############################################
#COPY resources/helpers/setup_amiepy.sh .
#RUN chmod +x setup_amiepy.sh && ./setup_amiepy.sh
#RUN rm setup_amiepy.sh


#########
# Cleanup
######### 

RUN rm -r $BUILD

WORKDIR /home/$NB_USER/work


#################
# asreimer: stuff to get gdrivefs working
# need to add the "Mounting Google Drive" notebook?
#
# USER root
#
# RUN apt-get install libfuse2 fuse
#
# USER $NB_USER
#
#COPY resources/MountingGoogleDrive.ipynb /home/$NB_USER/examples
#COPY resources/ExternalStorage.tar.gz /home/$NB_USER/work
#RUN tar -zxf ExternalStorage.tar.gz
#
#RUN /bin/bash -c 'source activate py27 && \
#    pip install oauth2client google-api-python-client && \
#    git clone https://github.com/dsoprea/GDriveFS && \
#    cd GDriveFS && \
#    git reset --hard 184dbfa6e94b210d47f4ef867134f02dde33fbbe && \
#    pip install . && \
#    cd .. && \
#    rm -rf GDriveFS'
#
#############
# ExternalStorage python package and example notebook
#
#RUN /bin/bash -c 'source activate py27 && \
#    pip install ./ExternalStorage --no-deps'
#
#RUN /bin/bash -c 'source activate py27 && pip install -U six'
#
#RUN rm -r /home/$NB_USER/work/ExternalStorage /home/$NB_USER/work/ExternalStorage.tar.gz

#############
# DataFetcher python package and example notebook

COPY resources/FetchingDataFromManifest.ipynb /home/$NB_USER/examples
COPY resources/test_manifest.json /home/$NB_USER/examples
COPY resources/FetchData.tar.gz /home/$NB_USER/work
RUN tar -zxf FetchData.tar.gz

RUN /bin/bash -c 'source activate py27 && \
    pip install ./FetchData --no-deps'

RUN /bin/bash -c 'source activate py27 && \
    pip install pandas'
RUN /bin/bash -c 'source activate py27 && \
    pip install -U numpy'

RUN rm -r /home/$NB_USER/work/FetchData /home/$NB_USER/work/FetchData.tar.gz

#############
# Russel's data gridder
#
#USER root
#RUN apt-get install ffmpeg
#
#USER $NB_USER
#
#RUN /bin/bash -c 'source activate py27 && \
#    pip install scikit-image h5py pyfits'

#COPY russel_gridding/data_gridding.tar.gz /home/$NB_USER/work
#COPY russel_gridding/geomag.tar.gz /home/$NB_USER/work
#RUN tar -zxf data_gridding.tar.gz
#RUN tar -zxf geomag.tar.gz
#RUN mv data_gridding /home/$NB_USER/examples
#
#RUN /bin/bash -c 'source activate py27 && \
#    pip install ./geomag --no-deps'
#
#RUN rm -r /home/$NB_USER/work/data_gridding.tar.gz /home/$NB_USER/work/geomag.tar.gz /home/$NB_USER/work/geomag


#######################################################################################
# POST INSTALLATION STUFF, SUCH AS CLEANUP
#######################################################################################



# Import spacepy once so that we get the .spacepy directory created
RUN /bin/bash -c 'source activate py27 && \
    python -c "import spacepy"'

# Needed for password-less login on jupyterhub when running locally.
RUN pip install jupyterhub-dummyauthenticator

RUN pip install jupyterlab