---
title: Creating an instance
---

## Creating an instance

To start the procedure of creating an instance, click on the **Create A New Instance** button on the VISA home page. You will then be guided through a few simple steps in order to create a virtual machine on the cloud infrastructure.

![](/api/docs/assets/visa-home.png)

### Select an experiment

The first step is to choose the experiments associated to your instance. These can be past experiments for which you want to perform data analysis or experiments in the current reactor cycle for which you wish to participate in remotely. Click on the **Select** button to associate specific experiments to your instance.

![](/api/docs/assets/visa-create-experiments.png)

### Instance settings

A computing *environment* and hardware settings (CPU and memory) are proposed by default. These settings are suitable for both data analysis and remote experimental control (using the Nomad client).

![](/api/docs/assets/visa-create-instance-settings.png)

The **Standard Analysis** *environment* is an Ubuntu 18.04 machine running the XFCE desktop manager and comes with pre-installed with all the analysis software. 

These settings can be changed by clicking on *Customise the instance setttings*. This way you can also modify the name of the instance and add some notes if you wish.

#### Computing Environment (available when selecting *Customise this instance settings*)

We currently only have one environment, the **Standard Analysis** environment as mentioned above. 

You can request different hardware requirements (flavours) depending on the type of data analysis to be performed. These are:

* **Small**: 2 Cores and 8GB RAM
* **Medium**: 4 Cores and 16GB RAM
* **Large**: 16 Cores and 128GB RAM

![](/api/docs/assets/visa-create-computing-environment.png)

You are free to choose any of the proposed flavours but due to the limited hardware that we have available we would kindly request that you choose the minimum necessary. We will be continuing to upgrade and add more capacity to our cloud infrastructure and the resources in these *flavours* will be improved too.

### Display settings

With VISA you can choose between single and dual screen layouts. The dual screen layout is particularly useful to allow for multiple windows to be visible on the same desktop. Different scaling options are available when viewing the remote desktop so even if your screen is smaller, all of the remote desktop is usable.

![](/api/docs/assets/visa-create-display-settings.png)

By default the single screen resolution is based on you current display. You can modify this by choosing a standard display resolution from the the drop-down list.

### Finalise the creation

In order to create the instance you must accept the terms and conditions. Once you've done this you can click on the **Create** button to build the virtual machine on the cloud infrastructure.

### Wait for the build process to complete

Having requested the instance to be created you are redirected back to the **Home** page. You will see that your instance appears at the top of the list and is currently *building*. 

![](/api/docs/assets/visa-create-building.png)

The build process (creation of the virtual machine and start-up of the Linux operating system and services) may take a few minutes. When it has completed you will see that the status has changed to active and that the **Connect** button is enabled.

![](/api/docs/assets/visa-create-active.png)
