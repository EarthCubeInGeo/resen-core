resen-core
==========
The core docker image used by `resen <https://github.com/EarthCubeInGeo/resen>`_.

Summary
=======

Resen (REproducible Software ENvironment), is a tool that enables reproducible scientific data analysis, built using python and docker.  It is designed to make it easier for geospace researchers to share analysis and results, as well as build off of work others have done.  Resen was developed under the InGeO project, currently supported by the National Science Foundation's Cyberinfrastructure for Sustained Scientific Innovation (CSSI) program (Grant \#1835573).  For more information about the InGeO project, please visit the `InGeO website <https://ingeo.datatransport.org>`_.

Resen is based on the concept of portable environments, or buckets, where code can be developed and run independent of a users system.  This repository contains the core docker image used to generate resen buckets.  It includes a python 2 and a python 3 environment, both with a variety of community geospace packages installed.



Usage
=====

Refer to the `resen <https://github.com/EarthCubeInGeo/resen>`_ repository and `documentation <https://resen.readthedocs.io/>`_ for usage instructions and example workflows.  There are jupyter notebooks containing tutorials of how to use python, resen, and a variety of community geospace software packages found in `resen-core/resources/tutorials`.
