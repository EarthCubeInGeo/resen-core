#!/bin/bash
######################################################################
#
#    A helper script for installing citationhelper
#
######################################################################

echo "*** Installing citationhelper ***"

source ${HOME}/envs/py27/bin/activate
pip install git+https://github.com/EarthCubeInGeo/citationhelper.git@v0.2
deactivate

source ${HOME}/envs/py36/bin/activate
pip install git+https://github.com/EarthCubeInGeo/citationhelper.git@v0.2
deactivate

echo "export CITEHELP_REFFILE=${HOME}/cache/pkg_citations.json" >> ${HOME}/.bashrc
