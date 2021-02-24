#!/bin/bash
#######################################################################################
#
#    A helper script for installing AMGeO
#
#    Assumes you have a py38 python virtual environments
#
#######################################################################################

echo "**** Installing AMGeO ****"

AMGEO_INSTALL_DIR=${HOME}/bin/amgeo
AMGEO_ARCHIVE=${HOME}/AMGeO-2.0.0beta.zip

# extract source and enter directory
mkdir -p ${AMGEO_INSTALL_DIR}
cd ${AMGEO_INSTALL_DIR}
unzip ${AMGEO_ARCHIVE} -d .
cd AMGeO-2.0.0beta

# install Python dependencies
source ${HOME}/envs/py38/bin/activate

pip install -e git+git://github.com/lkilcommons/geospacepy-lite.git#egg=geospacepy
pip install -e git+git://github.com/lkilcommons/OvationPyme.git#egg=ovationpyme
pip install -e git+git://github.com/lkilcommons/apex-python.git#egg=apexpython
pip install -e git+git://github.com/lkilcommons/nasaomnireader.git#egg=nasaomnireader

# install AMGeO
python setup.py develop

deactivate

# clean up archive
rm -r $AMGEO_ARCHIVE

# Now modify location where output files are saved by default
sed -i 's/    outdir = os.path.expanduser("~\/amgeo_v2_output")/    outdir = os.path.expanduser("~\/work\/amgeo_v2_output")/g' ${AMGEO_INSTALL_DIR}/AMGeO-2.0.0beta/AMGeO/driver_default.py