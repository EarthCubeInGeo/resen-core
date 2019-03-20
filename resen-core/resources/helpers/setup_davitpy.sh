#!/bin/bash
#######################################################################################
#
#    A helper script for installing davitpy
#
#    Assumes you have conda installed with a py27 virtual environment
#
#######################################################################################


source activate py27

CWD=$(pwd)

DAVITPY_BUILD_DIR=$CWD/davitpy_build
mkdir -p $DAVITPY_BUILD_DIR

git clone https://github.com/vtsuperdarn/davitpy.git
cd davitpy
git checkout tags/0.8-master -b 0.8-master
python setup.py install

# cleanup
cd $CWD
rm -r $DAVITPY_BUILD_DIR