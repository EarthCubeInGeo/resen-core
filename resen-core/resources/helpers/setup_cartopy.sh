#!/bin/bash
#######################################################################################
#
#    A helper script for installing cartopy
#
#    Assumes you have conda installed with a py27 virtual environment
#    and another environment with the name py36
#
#######################################################################################

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh

CWD=$(pwd)

CARTOPY_BUILD_DIR=$CWD/cartopy_build
mkdir -p $CARTOPY_BUILD_DIR

cd $CARTOPY_BUILD_DIR
git clone https://github.com/SciTools/cartopy.git
cd cartopy
git checkout tags/v0.17.0 -b v0.17.0

conda activate py27
LDFLAGS="-shared" pip install .

conda deactivate

conda activate py36
LDFLAGS="-shared" pip install .

# cleanup
cd $CWD
rm -r $CARTOPY_BUILD_DIR