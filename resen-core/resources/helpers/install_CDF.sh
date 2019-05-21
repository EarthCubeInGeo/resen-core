#!/bin/bash
#######################################################################################
#
#    A helper script for installing the NASA CDF library.
#
#
#    Currently installs the CDF library from:
#
#    http://spdf.sci.gsfc.nasa.gov/pub/software/cdf/dist/
#
#######################################################################################

CDF_TAR_FILE=cdf36_4-dist-cdf.tar.gz

wget https://spdf.sci.gsfc.nasa.gov/pub/software/cdf/dist/cdf36_4/linux/$CDF_TAR_FILE
tar xvf $CDF_TAR_FILE
cd cdf36_4-dist
make OS=linux ENV=gnu all
make INSTALLDIR=/usr/local install
cd ..
rm -rf $CDF_TAR_FILE
