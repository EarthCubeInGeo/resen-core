Usage
*****

Specific versions of resen-core are available through `resen`_. When creating a
`bucket`_ the user is asked to select a specific resen-core version to base
their `bucket`_ on.

Resen-core images
==============================

Alternatively to accesing resen-cores images through `resen`_, the images can
be pulled from `earchcubeingeo`_ on `dockerhub`_. The way `resen`_ obtains the
selected resen-core image is to pull it from `dockerhub`_ and once the
resen-core image has been pulled into the user's system it will be readily
available and no downloading will be needed. To pull a resen-core image from
`earchcubeingeo`_ the following `docker`_ command can be used::

    $ docker pull earthcubeingeo/resen-core:2019.1.0

After issuing the command, docker starts downloading the several layers
contained in the image and when the process finishes the image will be
available in the users's system::

    $ docker images

    REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
    earthcubeingeo/resen-core   2019.1.0            5300c6652851        7 months ago        4.45GB

Building a resen-core image
===========================

Resen-core images `Dockerfile` can be found inside the resen-core folder in the
`resen_core`_ `GitHub` repository. To build the image from the resen-core folder
where the Dockerfile is located run::

    $ docker build -t resen/testing .

After a successful build, which can take some time, the newly created image
should be available in the user's docker list::

    $ docker images

    REPOSITORY      TAG        IMAGE ID            CREATED             SIZE
    resen/testing   latest     5431trew4r12     2 hours ago         5.38GB


Resen-base
----------

The resen-core images are based on resen-base docker image which `Dockerfile`
is located inside the resen-base folder in the `resen_core`_ `GitHub`
repository. The resen-base in turn is based on the ubuntu:18.04 docker image
found in `ubuntu Docker Official Images`_.

resen-core Dockerfile helpers
-----------------------------

Resen-core uses additonal files (helpers) that are called as part of the
instructions in the `Dockerfile` The helpers are located inside the folder
resen-core/resources/helpers::

- install_CDF.sh
- setup_basemap.sh
- setup_cartopy.sh
- setup_davitpy.sh
- setup_py27_env.sh
- setup_py36_env.sh
- setup_spacepy.sh

Using a resen-core image without the `resen`_ tool
==================================================

There might be times when there is the need to use a resen-core image without
the `resen`_ tool, e.g. when a new image is being created and has not been
integrated in the `resen`_ tool. To proceed you need `docker`_ installed in your
system and enough resources allocated for the compilation. The following command
will start jupyter lab based on the resen-core image that was pulled previously
, i.e. earthcubeingeo/resen-core:2019.1.0 ::

    $ docker run --name a_container_name  -it -p XXXX:XXXX earthcubeingeo/resen-core:2019.1.0 /bin/bash -c 'source ~/envs/py36/bin/activate && jupyter lab --no-browser --ip 0.0.0.0 --port XXXX --NotebookApp.token=SOMETOKENWORD --KernelSpecManager.ensure_native_kernel=False'

where `XXXX` is the port to be used for `jupyterlab`.




.. _resen: https://resen.readthedocs.io/en/latest
.. _bucket: https://resen.readthedocs.io/en/latest/usage.html#setup-a-new-bucket
.. _docker: https://www.docker.com
.. _dockerhub: https://hub.docker.com
.. _earchcubeingeo: https://hub.docker.com/r/earthcubeingeo/resen-core/tags
.. _resen_core: https://github.com/EarthCubeInGeo/resen-core
.. _ubuntu Docker Official Images: https://hub.docker.com/_/ubuntu?tab=tags
