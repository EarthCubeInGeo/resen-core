#!/bin/bash
#######################################################################################
#
#    A helper script for installing pyglow
#
#    Assumes you have a py38 python virtual environments
#
#######################################################################################

echo "**** Installing pyglow ****"

PYGLOW_BUILD_DIR=pyglow_build

git clone https://github.com/timduly4/pyglow.git $PYGLOW_BUILD_DIR
cd $PYGLOW_BUILD_DIR
git checkout 054bf800263c01ecfa783741c9cfe8d3d6c259ca -b master_20190904

source ${HOME}/envs/py38/bin/activate

make -C src/pyglow/models source
pip install .
python -c "import pyglow"

deactivate

# cleanup
cd $BUILD
rm -r $PYGLOW_BUILD_DIR
