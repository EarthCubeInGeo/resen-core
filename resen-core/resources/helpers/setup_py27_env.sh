#!/bin/bash
#######################################################################################
#
#    A helper script for setting up a python 2.7 environment
#
#    Assumes you have conda >= 4.6.8
#
#######################################################################################

echo "**** Installing python 2.7 packages ****"

source /home/$NB_USER/envs/py27/bin/activate

# upgrade pip
pip install pip==19.2.3
pip install wheel ipython ipykernel
python -m ipykernel install --user --name py27 --display-name "py27"

# Now use pip to install everything we can
# Notes: pyproj==1.9.6 required for basemap, 2.0.0 breaks basemap
pip install -U paramiko==2.4.2 \
               ipython==5.8.0 \
               pymongo==3.7.2 \
               mechanize==0.4.1 \
               cryptography==2.6.1 \
               pytest==3.0.5 \
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
               sciunit2==0.4.post3.dev95073526 \
               madrigalweb==3.1.10 \
               pyproj==1.9.6 \
               cartopy==0.17.0 \
               bsddb3==6.2.6

# Custom pip installation for any package that needs it
LDFLAGS="-shared" pip install -UI apexpy==1.0.3 # have to install after installing numpy

deactivate

