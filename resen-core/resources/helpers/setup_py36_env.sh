#!/bin/bash
#######################################################################################
#
#    A helper script for setting up a python 3.6 environment
#
#    Assumes you have conda >= 4.6.8
#
#######################################################################################

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh

# Set up and activate the python3.6 environment
conda create --quiet --yes -n py36 python=3.6 pip=9.0.1

# Install binaries from Conda that are needed for python packages below
# linux only, can be swapped out for macosx and windows compilers as needed
conda install --yes -n py36 -c conda-forge gcc_linux-64==7.3.0 gfortran_linux-64==7.3.0 gxx_linux-64==7.3.0
# some of these are available for windows, some are not
conda install --yes -n py36 -c conda-forge mpich==3.2.1 hdf5==1.10.1 proj4==4.9.3 geos==3.7.1 ncurses==6.1 libffi==3.2.1 libnetcdf==4.6.1 openssl==1.1.1b freetype==2.9.1 libpng==1.6.36
#conda install --yes -n py36 -c anaconda libpng-devel-cos6-x86_64==1.2.49 

conda activate py36

# upgrade pip
pip install pip==19.0.3

# Now use pip to install everything we can
# Notes: pyproj==1.9.6 required for basemap, 2.0.0 breaks basemap
pip install -U paramiko==2.4.2 \
               ipython==7.4.0 \
               pymongo==3.7.2 \
               mechanize==0.4.1 \
               cryptography==2.6.1 \
               pytest==4.3.1 \
               nbformat==4.4.0 \
               numpy==1.16.2 \
               matplotlib==2.2.4 \
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
               pyproj==1.9.6 \
               madrigalweb==3.1.10

# Custom pip installation for any package that needs it
LDFLAGS="-shared" pip install -UI apexpy==1.0.3 # have to install after installing numpy

# Shapely is a requisite for cartopy
LDFLAGS="-shared" pip install -UI --no-binary :all: shapely==1.6.4.post2

# Installing cartopy
LDFLAGS="-shared" pip install -UI --no-binary :all: cartopy==0.17.0

# Remove pyqt and qt pulled in for matplotlib since we're only ever going to
# use notebook-friendly backends in these images
conda remove --quiet --yes -n py36 --force qt pyqt

# clean up tarballs and cache
conda clean -tipy
rm -rf ~/.cache/pip/*

conda deactivate
