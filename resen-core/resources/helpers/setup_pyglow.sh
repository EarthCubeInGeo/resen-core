#!/bin/bash
#######################################################################################
#
#    A helper script for installing pyglow
#
#    Assumes you have conda installed with a py27 virtual environment
#    and another environment with the name py36
#
#######################################################################################

echo "**** Installing pyglow ****"

cd $BUILD
PYGLOW_BUILD_DIR=pyglow_build

git clone https://github.com/timduly4/pyglow.git $PYGLOW_BUILD_DIR
cd $PYGLOW_BUILD_DIR
git checkout 054bf800263c01ecfa783741c9cfe8d3d6c259ca -b master_20190904

source /home/$NB_USER/envs/py27/bin/activate
make -C src/pyglow/models source
#cd src/pyglow/models
#make all
#cd ../../..
pip install .
python -c "import pyglow"

deactivate

source /home/$NB_USER/envs/py36/bin/activate
make -C src/pyglow/models source
#cd src/pyglow/models
#make all
#cd ../../..
pip install .
python -c "import pyglow"

# some post-pip initialization of packages
#cd $BUILD
#source /usr/local/bin/definitions.B # to set the CDF definitios including $CDF_LIB
#python -c "import spacepy.toolbox; spacepy.toolbox.update()"
# a file about 195 MB called OMNI_OMNI2_merged_20120213-v1.cdf
# has been created and will be removed later on. The data is kept
# inside ~/.spacepy
#echo "support_notice: False" >> /home/$NB_USER/.spacepy/spacepy.rc

#deactivate

# cleanup
cd $BUILD
rm -r $PYGLOW_BUILD_DIR
