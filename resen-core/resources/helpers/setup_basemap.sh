#!/bin/bash
#######################################################################################
#
#    A helper script for installing spacepy
#
#    Assumes you have conda installed with a py27 virtual environment
#    and another environment with the name py36
#
#######################################################################################

cd $BUILD
# git clone --depth 0 https://github.com/matplotlib/basemap.git # VERY SLOW
wget https://github.com/matplotlib/basemap/archive/v1.2.0rel.tar.gz
tar -zxf v1.2.0rel.tar.gz
cd basemap-1.2.0rel

source /home/$NB_USER/envs/py27/bin/activate
pip install .

deactivate

source /home/$NB_USER/envs/py36/bin/activate
pip install .

deactivate

# cleanup
cd $BUILD
rm -rf basemap-1.2.0rel
