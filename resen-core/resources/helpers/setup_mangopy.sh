#!/bin/bash
#######################################################################################
#
#    A helper script for installing mangopy
#
#    Assumes you have conda installed with a py27 virtual environment
#    and another environment with the name py36
#
#######################################################################################

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh

CWD=$(pwd)

MANGOPY_BUILD_DIR=$CWD/mangopy_build
mkdir -p $MANGOPY_BUILD_DIR

cd $MANGOPY_BUILD_DIR
git clone https://github.com/astib/MANGO.git
cd MANGO
#If we wanted a specific commit:
#git checkout b25cba78e58197394809cb8323656a1d636c3e3d -b master_06jun2019

conda activate py27
LDFLAGS="-shared" pip install .

conda deactivate

conda activate py36
LDFLAGS="-shared" pip install .

conda deactivate

# cleanup
cd $CWD
rm -r $MANGOPY_BUILD_DIR
