# Extend functionalities

## Table of contents

- [Install PYCUDA](#install-pycuda)
- [Use DASK with SLURM](#use-dask-with-slurm)
- [Use your own Conda environment](#use-your-own-conda-environment)

Though pip, you can add more packages to your python/Jupyter. The following are
examples that apply to python3

## Install PYCUDA

Open a Terminal in JupyterLab and run the following command:

```
python3 -m pip install pycuda --user
```

To test whether your PYCUDA works, try [this python script](pycuda.test.py.txt)
in JupyterLab. The script contains two URLs that explain the concepts of CUDA
thread blocks and thread indexing.

## Use DASK with SLURM

[DASK](https://docs.dask.org/en/latest/) allows you to break down a large
calculation into smaller parallel pieces. Here we are mostly interested in using
DASK to spread the calculation via multiple SLURM jobs.

To enable DASK distributed scheduling/running with SLURM, first make sure when
you start a JupyterLab instance, you choose an image that supports SLURM job
submission, such as `atlas-jupyter-w-slurm-cli/20200714`. You will also need to
use pip3 to install `dask-jobqueue` and `distributed`:

Open a Terminal in JupyterLab and run the following command:

```
python3 -m pip install --ignore-installed dask numpy dask-jobqueue distributed --user
```

To test whether it works, try [this python script](dask.slurm.test.py.txt) in
JupyterLab. Please pay attention to the line `python="/usr/bin/python3"` in the
script - do not forget about it.

## Use your own Conda environment

You can use your own
[Conda environment](https://conda.io/projects/conda/en/latest/user-guide/install/linux.html#)
along with the ATLAS Jupyter environment. Suppose you want to setup
[pyhf](https://github.com/scikit-hep/pyhf) via Conda, and use it in ATLAS
Jyputer environment, here is what you can do:

Open a Terminal in JupyterLab, you have two choices:
"`python3 -m pip install pyhf`" is the easiest way (but not via Conda). We want
to show how to do this in an Conda environment, and make it available in
Jupyter.

Suppose you already have miniconda3 or Anaconda3 install:

1. Create a new Conda environment, and name it "mypyhf":
   `conda create --name mypyhf`
2. Activate the environment: `conda activate mypyhf`
3. Install "ipykernel" and "pyhf" in this Conda environment:
   `conda install ipykernel pyhf`
4. Make this 'mypyhf' environment available in Jupyter:
   `python3 -m ipykernel install --user --name=mypyhf`
5. (To reverse, do `jupyter kernelspec uninstall mypyhf`)

After this and restart the Jupyter environment, you will see a new kernel call
`mypyhf`
