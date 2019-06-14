#!/bin/bash
#######################################################################################
#
#    A helper script for installing pyglow
#
#    Assumes you have conda installed with a py27 virtual environment
#    and another environment with the name py36
#
#######################################################################################

CONDA_BASE=$(conda info --base)
source $CONDA_BASE/etc/profile.d/conda.sh

CWD=$(pwd)

PYGLOW_BUILD_DIR=$CWD/mangopy_build
mkdir -p $PYGLOW_BUILD_DIR

cd $PYGLOW_BUILD_DIR
git clone https://github.com/timduly4/pyglow.git
cd pyglow
#specific working commit from master that worked when creating this helper
git checkout 83a055dae3aca540d0f862c7589a17fb14064e36 -b master_20190518_121258

conda activate py27
pip install -r requirements.txt
make -C src/pyglow/models source
LDFLAGS="-shared" pip install .
python -c "import pyglow"
conda deactivate

conda activate py36
pip install -r requirements.txt
make -C src/pyglow/models source
LDFLAGS="-shared" pip install .
python -c "import pyglow"
conda deactivate

# cleanup
cd $CWD
rm -r $PYGLOW_BUILD_DIR
