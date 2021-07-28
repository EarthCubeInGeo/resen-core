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
git checkout 9bf2b364aa66e3428a87888115fc3cbd2ab05540 -b master_20210104

source ${HOME}/envs/py38/bin/activate

make -C src/pyglow/models source
pip install .
python -c "import pyglow"

deactivate

# cleanup
cd $BUILD
rm -r $PYGLOW_BUILD_DIR
