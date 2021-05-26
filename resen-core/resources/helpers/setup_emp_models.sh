#!/bin/bash
####################################################################################
#
#    A helper script for installing the igrf, iri2016, and msise00
#    empirical models
#
#    Assumes you have a py38 virtual environment
#
####################################################################################

echo "**** Installing IGRF, IRI2016, & MSISE00 ****"
pwd

EMPMOD_BUILD_DIR=empmod_build
mkdir ${HOME}/${EMPMOD_BUILD_DIR}

# install  cmake
pwd
cd ${HOME}/${EMPMOD_BUILD_DIR}
pwd
wget https://github.com/Kitware/CMake/releases/download/v3.19.6/cmake-3.19.6.tar.gz
tar -xzf cmake-3.19.6.tar.gz && rm cmake-3.19.6.tar.gz
cd cmake-3.19.6
pwd
./bootstrap
make
make install
cd ${HOME}/${EMPMOD_BUILD_DIR}
pwd
# become jovyan user
su jovyan

# pip install igrf, iri, msise00
source /home/jovyan/envs/py38/bin/activate

pip install -U igrf==13.0.0 iri2016==1.11.1 msise00==1.10.0

# import in python
python -c "import igrf, iri2016, msise00"

# become root
su

# uninstall cmake
cd ${HOME}/${EMPMOD_BUILD_DIR}/cmake-3.19.6
pwd
make uninstall
cd ${HOME}
pwd
rm -r $EMPMOD_BUILD_DIR
