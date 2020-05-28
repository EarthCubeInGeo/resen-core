Usage
*****

Specific versions of resen-core are available through `resen`_. When creating a `bucket`_ the user is asked to select a specific resen-core version to base their `bucket`_ on.

Obtaining a resen-core image
==============================

Currently, the resen-core images can be pulled from `earchcubeingeo`_ on `dockerhub`_. The way `resen`_ obtains the selected resen-core image is to pull it from `dockerhub`_ and once the resen-core image has been pulled into the user's system it will be readily available and no downloading will be needed. To pull a resen-core image from `earchcubeingeo`_ the following `docker`_ command can be used::

    $ docker pull earthcubeingeo/resen-core:2019.1.0

After issuing the command, docker starts downloading the several layers contained in the image and when the process finishes the image will be available in the users's system::

    $ docker images

    REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
    earthcubeingeo/resen-core   2019.1.0            5300c6652851        7 months ago        4.45GB


Using a resen-core image without the `resen`_ tool
==================================================

There might be times when there is the need to use a resen-core image without the `resen`_ tool, e.g. when a new image is being created and has not been integrated in the `resen`_ tool. To proceed you need `docker`_ installed in your system and enough resources allocated for the compilation. The following command will start jupyter lab based on the resen-core image used::

    $ docker run --name a_container_name  -it -p XXXX:XXXX image_name:image_tag /bin/bash -c 'source ~/envs/py36/bin/activate && jupyter lab --no-browser --ip 0.0.0.0 --port XXXX --NotebookApp.token=qwerqwerqwer --KernelSpecManager.ensure_native_kernel=False'





.. _resen: https://resen.readthedocs.io/en/latest
.. _bucket: https://resen.readthedocs.io/en/latest/usage.html#setup-a-new-bucket
.. _docker: https://www.docker.com
.. _dockerhub: https://hub.docker.com
.. _earchcubeingeo: https://hub.docker.com/r/earthcubeingeo/resen-core/tags
