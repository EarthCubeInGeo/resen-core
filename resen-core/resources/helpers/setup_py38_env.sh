#!/bin/bash
#######################################################################################
#
#    A helper script for setting up a python 3.8 environment
#
#######################################################################################

echo "**** Installing python 3.8 packages ****"

# upgrade pip
pip install pip==21.1.2

# Now use pip to install everything we can
# NOTES: pyproj==1.9.6 required for basemap, 2.0.0 breaks basemap
#        jupyterhub, jupyterlab, notebook should all follow jupyterstacks versions
pip install -U jupyterhub==1.1.0 \
               jupyterlab==2.2.5 \
               notebook==6.1.3 \
               paramiko==2.7.2 \
               ipython==7.23.1 \
               pytest==6.2.4 \
               nbformat==5.0.7 \
               numpy==1.20.3 \
               matplotlib==3.4.2 \
               scipy==1.6.3 \
               tables==3.6.1 \
               sgp4==2.19 \
               pandas==1.2.4 \
               sympy==1.8 \
               sqlalchemy==1.4.15 \
               h5py==3.2.1 \
               pytz==2021.1 \
               netcdf4==1.5.6 \
               bokeh==2.3.2 \
               pyyaml==5.4.1 \
               cython==0.29.23 \
               pyproj==3.1.0 \
               madrigalweb==3.2 \
               bsddb3==6.2.9 \
               aacgmv2==2.6.2 \
               astropy==4.2.1 \
               plasmapy==0.6.0 \
               pydarn==2.0.1 \
               viresclient==0.8.0 \
               ipympl==0.7.0 \
               hdfviewer==0.11.0 \
               watermark==2.2.0 \
               seaborn==0.11.1 \
               ephem==3.7.7.1 \
               skyfield==1.39 \
               sciunit2==0.4.post58.dev224550607

#build matplotlib font cache
MPLBACKEND=Agg python -uc "import matplotlib.pyplot"

# install sunpy
pip install -U sunpy==3.0.0 beautifulsoup4==4.9.3 drms==0.6.2 zeep==4.0.0 tqdm==4.61.0 h5netcdf==0.11.0

# Custom pip installation for any package that needs it
pip install apexpy==1.1.0  # have to install after installing numpy

pip install cartopy==0.19.0.post1 # have to install after installing numpy

pip install pymap3d==2.7.0  # has side effects when importing first time
python -uc "import pymap3d"

pip install spacepy==0.2.2
source /usr/local/bin/definitions.B # to set the CDF definitios including $CDF_LIB
# only update omni and qin-denton since maia.usno.navy.mil/ser7/tai-utc.dat leapseconds website was down at the time...
python -uc "import spacepy.toolbox; spacepy.toolbox.update(QDomni=True)"
# spacepy 0.2.1 doesn't clean up this file. Submitted issue and PR to spacepy, see https://github.com/spacepy/spacepy/pull/219
rm OMNI_OMNI2_merged_20120213-v1.cdf

# Installing mangopy (14 June 2018)
pip install git+https://github.com/astib/MANGO.git@2dd4ca5380dca54cac8d2180c3ad63fc041a5c67

# Install visuamisr
pip install git+https://github.com/asreimer/visuamisr.git@v2.0.3

# Install citationhelper
pip install git+https://github.com/EarthCubeInGeo/citationhelper.git@v0.3

# cleanup
rm -rf ~/.cache/pip/*
