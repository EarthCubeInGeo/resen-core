#!/bin/bash
#######################################################################################
#
#    A helper script for installing spacepy
#
#    Assumes you have conda installed with a py27 virtual environment
#    and another environment with the name py36
#
#######################################################################################

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh

CWD=$(pwd)

BASEMAP_BUILD_DIR=$CWD/basemap_build
mkdir -p $BASEMAP_BUILD_DIR

cd $BASEMAP_BUILD_DIR
# git clone --depth 0 https://github.com/matplotlib/basemap.git # VERY SLOW
wget https://github.com/matplotlib/basemap/archive/v1.2.0rel.tar.gz
tar -zxf v1.2.0rel.tar.gz
cd basemap-1.2.0rel

conda activate py27
LDFLAGS="-shared" GEOS_DIR=$CONDA_BASE/envs/py27 pip install .

conda deactivate

conda activate py36
LDFLAGS="-shared" GEOS_DIR=$CONDA_BASE/envs/py36 pip install .

# cleanup
cd $CWD
rm -r $BASEMAP_BUILD_DIR