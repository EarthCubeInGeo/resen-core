#!/bin/bash
#######################################################################################
#
#    A helper script for installing basemap
#
#    Assumes you have py38 python virtual environments
#
#######################################################################################

# git clone --depth 0 https://github.com/matplotlib/basemap.git # VERY SLOW
wget https://github.com/matplotlib/basemap/archive/v1.2.2rel.tar.gz
tar -zxf v1.2.2rel.tar.gz
cd basemap-1.2.2rel

source ${HOME}/envs/py38/bin/activate
pip install .

deactivate

# cleanup
cd ..
rm -rf basemap-1.2.2rel v1.2.2rel.tar.gz
rm ${HOME}/.wget-hsts
