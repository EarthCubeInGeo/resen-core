#!/bin/bash
#######################################################################################
#
#    A helper script for installing davitpy
#
#    Assumes you have conda installed with a py27 virtual environment
#
#######################################################################################

source /home/$NB_USER/envs/py27/bin/activate

DAVITPY_BUILD_DIR=davitpy_build

cd $BUILD
git clone https://github.com/vtsuperdarn/davitpy.git $DAVITPY_BUILD_DIR
cd $DAVITPY_BUILD_DIR
git checkout tags/0.8-master -b 0.8-master

pip install .

# get hdw.dat and radar.dat - needed so davitpy can get radar information locally
mkdir -p /home/$NB_USER/cache
cd /home/$NB_USER/cache
git clone https://github.com/vtsuperdarn/hdw.dat.git
wget https://raw.githubusercontent.com/SuperDARN/rst/v4.2/tables/superdarn/radar.dat

deactivate

# cleanup
cd $BUILD
rm -rf $DAVITPY_BUILD_DIR
