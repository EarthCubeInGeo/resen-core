#!/bin/bash
#######################################################################################
#
#    A helper script for setting up a python 3.8 environment
#
#######################################################################################

echo "**** Installing python 3.8 packages ****"

# upgrade pip
pip install pip==20.2.3

# Now use pip to install everything we can
# NOTES: pyproj==1.9.6 required for basemap, 2.0.0 breaks basemap
#        jupyterhub, jupyterlab, notebook should all follow jupyterstacks versions
pip install -U jupyterhub==1.1.0 \
               jupyterlab==2.2.5 \
               notebook==6.1.3 \
               paramiko==2.7.2 \
               ipython==7.18.1 \
               pytest==5.4.3 \
               nbformat==5.0.7 \
               numpy==1.19.1 \
               matplotlib==3.3.1 \
               scipy==1.5.2 \
               tables==3.6.1 \
               sgp4==2.12 \
               pandas==1.1.2 \
               sympy==1.6.2 \
               sqlalchemy==1.3.19 \
               h5py==2.10.0 \
               pytz==2020.1 \
               netcdf4==1.5.4 \
               bokeh==2.2.1 \
               pyyaml==5.3.1 \
               cython==0.29.21 \
               pyproj==1.9.6 \
               madrigalweb==3.1.12 \
               bsddb3==6.2.7 \
               aacgmv2==2.6.0 \
               astropy==4.0.1.post1 \
               plasmapy==0.4.0 \
               pydarn==1.1.0 \
               viresclient==0.6.2 \
               ipympl==0.5.7 \
               hdfviewer==0.11.0 \
               watermark==2.0.2 \
               seaborn==0.11.0 \
               pyephem==3.7.7.0 \
               skyfield==1.26

#build matplotlib font cache
MPLBACKEND=Agg python -uc "import matplotlib.pyplot"

# install sunpy
pip install -U sunpy==2.0.1 beautifulsoup4==4.9.1 drms==0.5.7 zeep==3.4.0 tqdm==4.48.2

# Custom pip installation for any package that needs it
pip install apexpy==1.0.3  # have to install after installing numpy

pip install cartopy==0.18.0 # have to install after installing numpy

pip install pymap3d==2.4.1  # has side effects when importing first time
python -uc "import pymap3d"

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

# Install citationhelper
pip install git+https://github.com/EarthCubeInGeo/citationhelper.git@v0.2

# cleanup
rm -rf ~/.cache/pip/*
