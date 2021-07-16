resen-core
**********

Resen (REproducible Software ENvironment), is a tool that enables reproducible scientific data analysis, built using python and docker.  It is designed to make it easier for geospace researchers to share analysis and results, as well as build off of work others have done.  Resen was developed under the InGeO project, currently supported by the National Science Foundation's Cyberinfrastructure for Sustained Scientific Innovation (CSSI) program (Grant \#1835573).  For more information about the InGeO project, please visit the `InGeO website <https://ingeo.datatransport.org>`_.

`Resen <https://github.com/EarthCubeInGeo/resen>`_ is a command line tool designed to make it easy for users to access and manage reproducible software environments.  This repository contains the files necessary to create resen-core, the docker image used to define the software environment.  The resen-core image is built upon a standard Ubuntu Linux image with python, jupyter lab, and a stack of commonly used geospace software libraries and packages pre-installed.

Users who are only interested in using Resen for their scientific research and not developing the system should refer to the `resen documentation <https://resen.readthedocs.io/en/latest/>`_.  The files and documentation included in this repository are intended primarily for developers and advanced users who would like to customize their docker image.


Documentation
-------------

Complete documentation is available at `resen-core.readthedocs.io <https://resen-core.readthedocs.io/>`_.


.. Commenting out
   Usage
   =====

   There are jupyter notebooks of tutorials found in the tutorials directory.


.. _resen: https://resen.readthedocs.io/en/latest
