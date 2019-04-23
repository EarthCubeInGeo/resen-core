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

SHAPELY_BUILD_DIR=$CWD/shapely_build
CARTOPY_BUILD_DIR=$CWD/cartopy_build
mkdir -p $SHAPELY_BUILD_DIR
mkdir -p $CARTOPY_BUILD_DIR

# Shapely is a requisite for cartopy
cd $SHAPELY_BUILD_DIR
git clone https://github.com/Toblerity/Shapely.git
cd Shapely
git checkout tags/1.6.4.post2 -b 1.6.4.post2

conda activate py27
LDFLAGS="-shared" pip install .

conda activate py36
LDFLAGS="-shared" pip install .

conda deactivate

cd $CARTOPY_BUILD_DIR
git clone https://github.com/SciTools/cartopy.git
cd cartopy
git checkout tags/v0.17.0 -b v0.17.0

conda activate py27
LDFLAGS="-shared" pip install .

conda activate py36
LDFLAGS="-shared" pip install .

conda deactivate

# cleanup
cd $CWD
rm -r $CARTOPY_BUILD_DIR
rm -r $SHAPELY_BUILD_DIR
