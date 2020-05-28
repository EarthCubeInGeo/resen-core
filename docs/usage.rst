Usage
*****

Specific versions of resen-core are available through `resen`_. When creating a `bucket`_ the user is asked to select a specific resen-core version to base the `bucket`_ on.

Downloading a resen-core image
==============================

Currently, the resen-core images can be downloaded from `earchcubeingeo`_ on `dockerhub`_.


Using a resen-core image without the `resen`_ tool
==================================================

There might be times when there is the need to use a resen-core image without the `resen`_ tool, e.g. when a new image is being created and has not been integrated in the `resen`_ tool. To proceed you need `docker`_ installed in your system and enough resources allocated for the compilation. The following command will start jupyter lab based on the resen-core image used::

    $ docker run --name a_container_name  -it -p XXXX:XXXX image_name:image_tag /bin/bash -c 'source ~/envs/py36/bin/activate && jupyter lab --no-browser --ip 0.0.0.0 --port XXXX --NotebookApp.token=qwerqwerqwer --KernelSpecManager.ensure_native_kernel=False'





.. _resen: https://resen.readthedocs.io/en/latest
.. _bucket: https://resen.readthedocs.io/en/latest/usage.html#setup-a-new-bucket
.. _docker: https://www.docker.com
.. _dockerhub: https://hub.docker.com
.. _earchcubeingeo: https://hub.docker.com/r/earthcubeingeo/resen-core
