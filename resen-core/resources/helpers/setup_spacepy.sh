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

SPACEPY_BUILD_DIR=$CWD/spacepy_build
mkdir -p $SPACEPY_BUILD_DIR

cd $SPACEPY_BUILD_DIR
git clone https://github.com/spacepy/spacepy.git
cd spacepy
git checkout 8b8c2d56ebdcb1d3a59fd868a1c92f34ce16ec64 -b 0.1.6_withfix

conda activate py27
LDFLAGS="-shared" pip install .

conda deactivate

conda activate py36
LDFLAGS="-shared" pip install .

# some post-pip initialization of packages
python -c "import spacepy.toolbox; spacepy.toolbox.update()"

conda deactivate

echo "support_notice: False" >> ~/.spacepy/spacepy.rc

# cleanup
cd $CWD
rm -r $SPACEPY_BUILD_DIR