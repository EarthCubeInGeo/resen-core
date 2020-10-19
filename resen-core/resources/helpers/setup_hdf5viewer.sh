#!/bin/bash
#######################################################################################
#
#    A helper script for installing pyglow
#
#    Assumes you have conda installed with a py27 virtual environment
#    and another environment with the name py36
#
#######################################################################################

echo "**** Installing hdf5 viewer ****"

cd $BUILD
HDF5VIEWER_BUILD_DIR=hdf5viewer_build

git clone https://github.com/pmreyes2/jupyterlab-hdf5.git $HDF5VIEWER_BUILD_DIR

cd $HDF5VIEWER_BUILD_DIR

git checkout a8a0e9bb1771ffa630cd8ead940ac7b258e1ad8b -b master_20190921

source /home/$NB_USER/envs/py36/bin/activate

export PATH=/usr/local/lib/nodejs/node-v10.16.3-linux-x64/bin:$PATH
pip install .
jupyter labextension install jupyterlab-hdf

deactivate

# cleanup
cd $BUILD
rm -r $HDF5VIEWER_BUILD_DIR
