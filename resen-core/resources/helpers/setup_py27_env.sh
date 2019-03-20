#!/bin/bash
#######################################################################################
#
#    A helper script for setting up a python 2.7 environment
#
#    Assumes you have conda installed
#
#######################################################################################

# Set up and activate the python2.7 environment
conda create --quiet --yes -n py27 python=2.7 pip=9.0.1
source activate py27

# Install packages that have system package dependencies
conda install cartopy=0.17.0 basemap=1.2.0

# upgrade pip
pip install pip==19.0.3

# Now use pip to install everything we can
pip install -U sciunit2==0.4.post3.dev95073526 \
               paramiko==2.4.2 \
               apexpy==1.0.3 \
               ipython==5.8.0 \
               pymongo==3.2.2 \
               mechanize==0.2.5 \
               netcdf4==1.2.7 \
               cryptography==2.6.1 \
               pytest==3.0.5 \
               nbformat==4.4.0 \
               numpy==1.16.2 \
               matplotlib==3.0.3 \
               scipy==1.2.1 \
               tables==3.5.1 \
               sgp4==1.4 \
               pandas==0.24.2 \
               sympy==1.1.0 \
               sqlalchemy==1.3.1 \
               h5py==2.9.0 \
               pytz==2018.9 \
               netcdf4==1.4.3 \
               bokeh==1.0.4 \
               pyyaml==5.1 \
               cython==0.29.6 \

# numpy? matplotlib? scipy?

# Custom pip installation for any package that needs it
BERKELEYDB_DIR=/opt/conda pip install bsddb3==6.2.6


# why was this line in the Dockerfile Todd?
#conda remove --quiet --yes -n python2 --force qt pyqt

# clean up tarballs and cache
conda clean -tipy

conda deactivate