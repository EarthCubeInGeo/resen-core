#!/bin/bash
#######################################################################################
#
#    A helper script for installing davitpy
#
#    Assumes you have conda installed with a py27 virtual environment
#
#######################################################################################

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh


CWD=$(pwd)

DAVITPY_BUILD_DIR=$CWD/davitpy_build
mkdir -p $DAVITPY_BUILD_DIR

git clone https://github.com/vtsuperdarn/davitpy.git
cd davitpy
git checkout tags/0.8-master -b 0.8-master

conda activate py27
LDFLAGS="-shared" pip install .

# get hdw.dat and radar.dat - needed so davitpy can get radar information locally
cd $HOME/cache
git clone https://github.com/vtsuperdarn/hdw.dat.git
wget https://raw.githubusercontent.com/SuperDARN/rst/master/tables/superdarn/radar.dat

# cleanup
cd $CWD
rm -r $DAVITPY_BUILD_DIR