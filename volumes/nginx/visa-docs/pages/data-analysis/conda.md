---
title: How do I use Conda to manage analysis environments?
---

## About Conda

Conda is a package manager and environment manager that allows you to create and use environments for specific analysis purposes. 

Conda quickly installs, runs and updates packages and their dependencies. Conda easily creates, saves, loads and switches between environments on your instance. It was created for Python programs, but it can package and distribute software for any language.

More information about Conda can be found [here](https://docs.conda.io).

## Activating Conda

Before using Conda it needs to be activated in your terminal. To do this type the following command:

```
> source /opt/conda/etc/profile.d/conda.sh
```

## Managing Conda environments

We present here a very brief introduction to using Conda. For more information on managing environments in Conda please refer to the [official documentation](
https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html#managing-environments).

To create an environment you use the command `conda create` like in the following example:

```
> conda create --name snowflakes biopython
```

You will be prompted to proceed to create the environment.

To see the available environments you can type the following command:

```
> conda info --envs
```

To activate a Conda environment you use the command `conda activate` such as:

```
> conda activate snowflakes
(snowflakes) >
```

To deactivate a Conda environment, type `conda deactivate`.

### Specifying where to store Conda environments

You an specify where you create a Conda environment by adding the `--prefix` argument to the creation command:

```
> conda create --name snowflakes --prefix=<my/specific/conda/path> biopython 
```

This will create the Conda environment in the specified path (ie `my/specific/conda/path`).

## How do I make my Conda environment available inside JupyterLab?

As well as using your Conda environment through the command line, you can also make it available through the VISA JupyterLab environment of your instance.

A couple of commands are necessary to make this possible. First of all you need to install `ìpykernel` from within the activated Conda environment. Using the example environment created above, run the following commands:

```
> conda activate snowflakes
(snowflakes) > conda install ipykernel
(snowflakes) > python -m ipykernel install --user --name=snowflakes
```

If you then [open the JupyterLab environment](/help/instances/open-jupyterlab) you will find the new environment is available for use.

![](/api/docs/assets/visa-conda-jupyter.png)

