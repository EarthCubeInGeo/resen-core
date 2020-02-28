resen-core
==========
The core docker image used by `resen <https://github.com/EarthCubeInGeo/resen>`_.

Summary
=======

Resen (REproducible Software ENvironment), is a tool that enables reproducible scientific data analysis, built using python and docker.  It is designed to make it easier for geospace researchers to share analysis and results, as well as build off of work others have done.  Resen was developed under the InGeO project, currently supported by the National Science Foundation's Cyberinfrastructure for Sustained Scientific Innovation (CSSI) program (Grant \#1835573).  For more information about the InGeO project, please visit the `InGeO website <https://ingeo.datatransport.org>`_.

Resen is based on the concept of portable environments, or buckets, where code can be developed and run independent of a users system.  When you start a resen bucket, it has a variety of common geospace software packages preinstalled and ready for use.  This means you have easy access to common models and datasets, and can start using them in your analysis immediately.  You can also set up your bucket to access your own datasets, locally stored on your machine.

After you have completed your analysis, you can share an entire bucket with other researchers.  Within the bucket, your analysis code will always run exactly the same way, regardless of what system the bucket is on.  This means that other researchers should be able to reproduce your work and start building off of it immediately, instead of spending time configuring their system, installing new packages, and setting up file paths so their environment is compatible with your code.



Usage
=====

Refer to the `resen <https://github.com/EarthCubeInGeo/resen>`_ repository and `documentation <https://resen.readthedocs.io/>`_ for usage instructions and example workflows.  There are jupyter notebooks containing tutorials of how to use python, resen, and a variety of community geospace software packages found in `resen-core/resources/tutorials`.
