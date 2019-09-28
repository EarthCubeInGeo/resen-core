#!/bin/bash
#######################################################################################
#
#    A helper script for setting up a python 3.6 environment
#
#######################################################################################

echo "**** Installing python 3.6 packages ****"

# upgrade pip
pip install pip==19.2.3

# Now use pip to install everything we can
# Notes: pyproj==1.9.6 required for basemap, 2.0.0 breaks basemap
pip install -U jupyterhub==1.0.0 \
               jupyterlab==0.35.6 \
               notebook==6.0.1 \
               paramiko==2.4.2 \
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
               madrigalweb==3.1.10 \
               cartopy==0.17.0 \
               bsddb3==6.2.6 \
               aacgmv2==2.5.2 \
               pymap3d==2.1.0

# Custom pip installation for any package that needs it
pip install apexpy==1.0.3  # have to install after installing numpy

# Need to install spacepy from specific commit (see https://github.com/spacepy/spacepy/issues/203#issuecomment-536112039)
pip install git+https://github.com/spacepy/spacepy.git@736df223a067574f9f87c2697f61d17eb39898a3
source /usr/local/bin/definitions.B # to set the CDF definitios including $CDF_LIB
python -c "import spacepy.toolbox; spacepy.toolbox.update()"
echo "support_notice: False" >> ~/.spacepy/spacepy.rc

# Installing mangopy (14 June 2018)
pip install git+https://github.com/astib/MANGO.git@2dd4ca5380dca54cac8d2180c3ad63fc041a5c67

# cleanup
rm -rf ~/.cache/pip/*