#!/bin/bash
####################################################################################
#
#    A helper script for installing the igrf, iri2016, and msise00
#    empirical models
#
#    Assumes you are root and have a py38 virtual environment in /home/jovyan/envs
#
####################################################################################

echo "**** Installing IGRF, IRI2016, & MSISE00 ****"
pwd

apt-get update && apt-get install -yq --no-install-recommends \
    cmake && \
    rm -rf /var/lib/apt/lists/*

# install igrf, iri, msise00
su -l jovyan -c "source /home/jovyan/envs/py38/bin/activate && pip install -U igrf==13.0.0 iri2016==1.11.1 msise00==1.10.0"
su -l jovyan -c 'source /home/jovyan/envs/py38/bin/activate && python -c "import igrf; mag = igrf.igrf(\"2010-07-12\", glat=65, glon=-148, alt_km=100)"'
su -l jovyan -c 'source /home/jovyan/envs/py38/bin/activate && python -c "import iri2016.profile as iri; from datetime import datetime, timedelta; sim = iri.timeprofile((datetime(2020, 6, 1, 0, 0, 0), datetime(2020, 6, 2)), timedelta(minutes=30), (100, 500, 10.), 65, -147.5)"'
su -l jovyan -c 'source /home/jovyan/envs/py38/bin/activate && python -c "import msise00; from datetime import datetime; atmos = msise00.run(time=datetime(2013, 3, 31, 12), altkm=150., glat=65., glon=-148.)"'


apt-get remove -yq cmake && apt-get autoremove -yq