#!/bin/bash
#######################################################################################
#
#    A helper script for installing spacepy
#
#    Assumes you have conda installed with a py27 virtual environment
#    and another environment with the name py36
#
#######################################################################################

echo "**** Installing spacepy ****"

cd $BUILD
SPACEPY_BUILD_DIR=spacepy_build

git clone https://github.com/spacepy/spacepy.git $SPACEPY_BUILD_DIR
cd $SPACEPY_BUILD_DIR
git checkout 8b8c2d56ebdcb1d3a59fd868a1c92f34ce16ec64 -b 0.1.6_withfix

source /home/$NB_USER/envs/py27/bin/activate
pip install .

deactivate

source /home/$NB_USER/envs/py36/bin/activate
pip install .

# some post-pip initialization of packages
cd $BUILD
source /usr/local/bin/definitions.B # to set the CDF definitios including $CDF_LIB
python -c "import spacepy.toolbox; spacepy.toolbox.update()"
# a file about 195 MB called OMNI_OMNI2_merged_20120213-v1.cdf
# has been created and will be removed later on. The data is kept
# inside ~/.spacepy
echo "support_notice: False" >> /home/$NB_USER/.spacepy/spacepy.rc

deactivate

# cleanup
cd $BUILD
rm -r $SPACEPY_BUILD_DIR
