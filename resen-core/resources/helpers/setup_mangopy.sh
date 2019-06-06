#!/bin/bash
#######################################################################################
#
#    A helper script for installing mangopy
#
#    Assumes you have a py27 virtual environment
#    and another environment with the name py36
#
#######################################################################################

echo "**** Installing mangopy ****"

CWD=$(pwd)

MANGOPY_BUILD_DIR=$CWD/mangopy_build
mkdir -p $MANGOPY_BUILD_DIR

cd $MANGOPY_BUILD_DIR
git clone https://github.com/astib/MANGO.git
cd MANGO
#If we wanted a specific commit:
#git checkout b25cba78e58197394809cb8323656a1d636c3e3d -b master_06jun2019

source /home/$NB_USER/envs/py27/bin/activate
LDFLAGS="-shared" pip install .

deactivate

source /home/$NB_USER/envs/py36/bin/activate
LDFLAGS="-shared" pip install .

deactivate

# cleanup
cd $CWD
rm -r $MANGOPY_BUILD_DIR
