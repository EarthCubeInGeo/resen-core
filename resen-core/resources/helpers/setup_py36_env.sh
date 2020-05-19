#!/bin/bash
#######################################################################################
#
#    A helper script for setting up a python 3.6 environment
#
#######################################################################################

echo "**** Installing python 3.6 packages ****"

# upgrade pip
pip install pip==20.1

# Now use pip to install everything we can
# Notes: pyproj==1.9.6 required for basemap, 2.0.0 breaks basemap
pip install -U jupyterhub==1.0.0 \
               jupyterlab==2.1.2 \
               notebook==6.0.3 \
               paramiko==2.7.1 \
               ipython==7.14.0 \
               pymongo==3.10.1 \
               mechanize==0.4.5 \
               cryptography==2.9.2 \
               pytest==5.4.2 \
               nbformat==5.0.6 \
               numpy==1.16.2 \
               matplotlib==3.2.1 \
               scipy==1.4.1 \
               tables==3.6.1 \
               sgp4==2.8 \
               pandas==1.0.3 \
               sympy==1.5.1 \
               sqlalchemy==1.3.17 \
               h5py==2.10.0 \
               pytz==2020.1 \
               netcdf4==1.5.3 \
               bokeh==2.0.2 \
               pyyaml==5.3.1 \
               cython==0.29.18 \
               pyproj==2.6.1.post1 \
               madrigalweb==3.1.12 \
               bsddb3==6.2.7 \
               aacgmv2==2.6.0 \
               pymap3d==2.4.1 \
               astropy==3.2.1 \
               plasmapy==0.3.1 \
               pydarn==1.0.0.1 \
               viresclient==0.6.1
               # sunpy==1.1.3

# Custom pip installation for any package that needs it
pip install apexpy==1.0.3  # have to install after installing numpy

pip install cartopy==0.18.0 # have to install after installing numpy

pip install spacepy==0.2.1
source /usr/local/bin/definitions.B # to set the CDF definitios including $CDF_LIB
# only update omni and qin-denton since maia.usno.navy.mil/ser7/tai-utc.dat leapseconds website was down at the time...
python -uc "import spacepy.toolbox; spacepy.toolbox.update(QDomni=True)"
# spacepy 0.2.1 doesn't clean up this file. Submitted issue and PR to spacepy, see https://github.com/spacepy/spacepy/pull/219
rm OMNI_OMNI2_merged_20120213-v1.cdf

# Installing mangopy (14 June 2018)
pip install git+https://github.com/astib/MANGO.git@2dd4ca5380dca54cac8d2180c3ad63fc041a5c67

# Install visuamisr
pip install git+https://github.com/asreimer/visuamisr.git@v2.0.3

# cleanup
rm -rf ~/.cache/pip/*
