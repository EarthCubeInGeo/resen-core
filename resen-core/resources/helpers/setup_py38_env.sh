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
pip install -U jupyter-core==4.7.1
pip install -U jupyterhub==1.1.0
pip install -U jupyterlab==3.0.16
pip install -U notebook==6.4.0
pip install -U paramiko==2.7.2
pip install -U ipython==7.24.1
pip install -U pytest==6.2.4
pip install -U nbformat==5.0.7
pip install -U numpy==1.20.3
pip install -U matplotlib==3.4.2
pip install -U scipy==1.6.3
pip install -U tables==3.6.1
pip install -U sgp4==2.19
pip install -U pandas==1.2.4
pip install -U sympy==1.8
pip install -U sqlalchemy==1.4.15
pip install -U h5py==3.2.1
pip install -U pytz==2021.1
pip install -U netcdf4==1.5.6
pip install -U bokeh==2.3.2
pip install -U pyyaml==5.4.1
pip install -U cython==0.29.23
pip install -U pyproj==1.9.6
pip install -U madrigalweb==3.2
pip install -U bsddb3==6.2.9
pip install -U aacgmv2==2.6.2
pip install -U astropy==4.2.1
pip install -U plasmapy==0.6.0
pip install -U pydarn==2.1.0
pip install -U viresclient==0.8.0
pip install -U hdfviewer==0.11.0
pip install -U watermark==2.2.0
pip install -U seaborn==0.11.1
pip install -U ephem==3.7.7.1
pip install -U skyfield==1.39
pip install -U sciunit2==0.4.post58.dev224550607
pip install -U pysat==3.0.0
pip install -U xarray==0.18.2

# install jupyterlab prebuilt extension
pip install ipywidgets==7.6.3 ipympl==0.7.0 jupyter_bokeh==3.0.2 jupyterlab_widgets==1.0.0

#build matplotlib font cache
MPLBACKEND=Agg python -uc "import matplotlib.pyplot"

# install sunpy
pip install -U sunpy==3.0.0 beautifulsoup4==4.9.3 drms==0.6.2 zeep==4.0.0 tqdm==4.61.0 h5netcdf==0.11.0

# Custom pip installation for any package that needs it
pip install apexpy==1.1.0  # have to install after installing numpy

pip install OMMBV==0.5.4  # install after numpy
python -uc "import OMMBV"

pip install cartopy==0.19.0.post1 # have to install after installing numpy

pip install pymap3d==2.7.0  # has side effects when importing first time
python -uc "import pymap3d"

pip install spacepy==0.2.2
source /usr/local/bin/definitions.B # to set the CDF definitios including $CDF_LIB
# only update omni and qin-denton since maia.usno.navy.mil/ser7/tai-utc.dat leapseconds website was down at the time...
python -uc "import spacepy.toolbox; spacepy.toolbox.update(QDomni=True)"

# Installing mangopy (14 June 2018)
pip install git+https://github.com/astib/MANGO.git@2dd4ca5380dca54cac8d2180c3ad63fc041a5c67

# Install visuamisr
pip install git+https://github.com/asreimer/visuamisr.git@v2.0.3

# Install citationhelper
pip install git+https://github.com/EarthCubeInGeo/citationhelper.git@v0.3

# cleanup
rm -rf ~/.cache/pip/*
