Notes for Developers
********************

Notes to create, build, and test resen-core images.

Resen-core images
=================

Alternatively to accessing resen-cores images through `resen`_, the images can
be pulled from `earchcubeingeo`_ on `dockerhub`_ (this is how `resen`_ obtains the
selected resen-core image).  Once the resen-core image has been pulled into the 
user's system it will be readily available and not require downloading in the future. 
To pull a resen-core image from `earchcubeingeo`_ the following `docker`_ command 
can be used::

    $ docker pull earthcubeingeo/resen-core:2020.2.0

After issuing the command, docker starts downloading the layers
contained in the image. When the process finishes the image will be
available in the user's system::

    $ docker images

    REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
    earthcubeingeo/resen-core   2020.2.0            b1f1c9013924        1 day ago           5.25GB

Building a resen-core image
===========================

The sources for building a resen-core image are in the `resen_core`_ `GitHub`
repository. The `Dockerfile` for the resen-core image can be found inside the
resen-core folder in the repository. To build the image from the resen-core folder
run::

    $ docker build -t resencoretest .

After a successful build, which can take some time, the newly created image
should be available in the user's docker list::

    $ docker images

    REPOSITORY      TAG        IMAGE ID            CREATED             SIZE
    resencoretest  latest     5431trew4r12     2 hours ago         5.38GB

Resen-base
----------

The resen-core images are based on the resen-base docker image, whos `Dockerfile`
is located inside the resen-base folder in the `resen_core`_ `GitHub`
repository. The resen-base image is in turn based on the ubuntu:20.04 docker image
found in `ubuntu Docker Official Images`_.

Building a resen-base image
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The sources for building a resen-base image are in the `resen_core`_ `GitHub`
repository. The `Dockerfile` for the resen-core image can be found inside the
resen-base folder in the repository. To build the image from inside the
resen-base folder run::

    $ docker build -t resenbasetest .

To use the newly generated resen-base image and use it in resen-core, the
`resen-core/Dockerfile` needs to be modified so that it uses `resenbasetest`
instead of `earthcubeingeo/resen-base:2020.2.0`

    FROM resenbasetest:latest

resen-core Dockerfile helpers
-----------------------------

Resen-core uses additonal files (helpers) that are called as part of the
instructions in the `Dockerfile` The helpers are located inside the folder
resen-core/resources/helpers::

- install_CDF.sh
- setup_basemap.sh
- setup_py38_env.sh
- setup_pyglow.sh

Using a resen-core image without the `resen`_ tool
==================================================

There might be times when there is the need to use a resen-core image without
the `resen`_ tool, e.g. when a new image is being created and has not been
integrated in the `resen`_ tool. To proceed you need `docker`_ installed in your
system and enough resources allocated for compilation. The following command
will start jupyter lab based on the resen-core image that was pulled previously
, i.e. earthcubeingeo/resen-core:2020.2.0 ::

    $ docker run --name a_container_name  -it -p XXXX:XXXX earthcubeingeo/resen-core:2020.2.0 /bin/bash -c 'source ~/envs/py38/bin/activate && jupyter lab --no-browser --ip 0.0.0.0 --port XXXX --NotebookApp.token=SOMETOKENWORD --KernelSpecManager.ensure_native_kernel=False'

where `XXXX` is the port to be used for `jupyterlab`.




.. _resen: https://resen.readthedocs.io/en/latest
.. _bucket: https://resen.readthedocs.io/en/latest/usage.html#setup-a-new-bucket
.. _docker: https://www.docker.com
.. _dockerhub: https://hub.docker.com
.. _earchcubeingeo: https://hub.docker.com/r/earthcubeingeo/resen-core/tags
.. _resen_core: https://github.com/EarthCubeInGeo/resen-core
.. _ubuntu Docker Official Images: https://hub.docker.com/_/ubuntu?tab=tags
