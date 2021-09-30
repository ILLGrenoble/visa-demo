# Building the VISA Example Image

The VISA demo requires you to have the [example VISA Virtual Machine Image](https://github.com/ILLGrenoble/visa-image-template-example) uploaded into OpenStack.

OpenStack uses images to create running virtual machines (or instances). Many different types of images can be used by OpenStack, however VISA requires a VM with a linux environment and certain services to be pre-installed.

The process to build the example VISA virtual machine image is very simple but requires a few dependencies to be installed in a Ubuntu/Debian environment. If you wish to build the image fully autonomously, we describe the process using Vagrant below

We strongly recommend that you build this directly (as described by the project). The build process is much faster when done directly rather than via vagrant (which can take several hours). 

> Note that if you are running behind an HTTP proxy, the environment variables `http_proxy`, `https_proxy` and `no_proxy` must be set.

## Building the image directly (recommended)

To build the example VISA Virtual Machine Image directly using the recommended build process, follow the [installation instructions](https://github.com/ILLGrenoble/visa-image-template-example/blob/main/README.md#installation) provided in the image project.

As discussed in the documentation, we recommend an Ubuntu or Debian environment in which you'll have to install some specific dependencies. The process to build the image is then scripted and takes less than an hour to complete.

## Building the image using Vagrant

To build the example VISA image using Vagrant run the following command:

```bash
vagrant up build_image
```

This will launch an Ubuntu environment and install all the necessary dependencies automatically. The script to build the image is then launched.

> Please not, the generation process can take a several hours.

Once this completes, the virtual machine image will be stored in `build/visa-apps.img`.

To stop and delete the virtual machine used to build the image run the following command:

```bash
vagrant destroy build_image
```

This will not remove the generated image.

## Uploading the image to OpenStack

Having built the image using one of the processes described above, you will have to upload the image to OpenStack. This can be done directly using the the admin UI of OpenStack, or the OpenStack CLI client. For more information on how to do this please follow the [image upload documentation](https://github.com/ILLGrenoble/visa-image-template-example/blob/main/README.md#upload-an-image-to-openstack).

