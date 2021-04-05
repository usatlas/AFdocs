# [The SLAC JupyterLab](https://sdf.slac.stanford.edu/public/doc/#/interactive-compute?id=jupyter)

## Table of contents
+ [Login to JupyterLab at SLAC](#login-to-jupyterlab-at-slac)
+ [A note about yoru AFS or GPFS spaces](#a-note-about-your-afs-or-gpfs-spaces)
+ [How to launch JupyterLab at SLAC](#how-to-launch-jupyterlab-at-slac)
+ [Run your own Jupyter environment](#run-your-own-jupyter-environment)
+ [An alternative way to use the ATLAS Jupyter environment at SLAC](#an-alternative-way-to-use-the-atlas-jupyter-environment-at-slac)
+ [Kernels and extensions in the ATLAS Jupyter environment](#kernels-and-extensions-in-the-atlas-jupyter-environment)
+ [Extend ATLAS JupyterLab Functionalities](#extend-atlas-jupyterlab-functionalities)
+ [Getting help](#getting-help)

## Login to JupyterLab at SLAC

Before accessing [the SLAC JupyterLab](https://sdf.slac.stanford.edu/public/doc/#/interactive-compute?id=jupyter), please [apply for a SLAC computing account](https://atlas.slac.stanford.edu/using-the-slac-computing-resources). 

You need to use your "SLAC ID" (aka SLAC Windows account) to login to SLAC JupyterLab. For more information regarding "SLAC ID", please refer to ["SDF: New SLAC..."](../#sdf).

## A note about your AFS or GPFS spaces

SLAC JupyterLab will put you on a new 25GB home directory `/sdf/home/<username_initial>/<username>`. If you have GPFS or AFS spaces at SLAC, you will find that the JupyterLab can access GPFS spaces but can not access AFS space. You will need to manually copy your files from AFS to the new home. In JupyterLab's terminal, you can run scp/sftp to copy files.

## How to launch JupyterLab at SLAC

Once you login, click "Interactive Apps" from the top menu bar. Then choose "Jupyter". You will need to make a few choices:

1. In "Jupyter Instance" box, choose "atlas/20210403". You can choose Jupyter Instances for other experiments but there is no guarantee that those instances will work for you.
2. Check the "Use JupyterLab instead of Jupyter Notebook?" box.
3. In the "Partition" box, you can type in "usatlas" or "shared". Compare to "usatlas", "shared" may give you a quicker access but you may face preemption. If you have been told that you can use other SLURM partitions, please type at here.
4. Choose hours, # CPUs, memory, # GPUs and GPU type, then click "launch". Note that your Jupyter work runs as a SLURM job. So choose only what you need to ensure speedy launching of your job.

## Run your own Jupyter environment

The ATLAS instance we built may not satisfy your need. If you have your own Jupyter environment that is accessible from SLAC (on SLAC disk or in CVMFS), you may be able to run it on SLAC's Jupyter infrastracture. To do so:

1. Following the same steps above to launch Jupyter at SLAC.
2. Instead of choosing the "atlas-jupyter..." instance, you choose "Custom Singularity Image" or "[Custom Conda Environment](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html)".
3. The "Commands to initate Jupyter" box will be pre-filled with commands to prepare your instance. You can edit/paste whatever Shell script to the box to prepare launching your Jupyter environment. 
4. A backend launching script will "source" your Shell script. It expects that after "sourcing", there is a command (or Shell function) called "jupyter" for it to run. It will then run one of the following commands, `jupyter notebook` or `jupyter lab` (depend on whether you choose Jupyter Notebook or Jupyter Lab) to launch your Jupyter environment.
5. Below are example scripts to prepare for launching Jupyter from a Singularity container:

~~~
export SINGULARITY_IMAGE=/gpfs/slac/.../my_singularity_image.sif
function jupyter() { singularity exec --nv -B /gpfs,/scratch,/nfs,/gpfs ${SINGULARITY_IMAGE} jupyter $@ }
~~~
or from a Conda environment (assuming Anaconda 3 is installed at ~/anaconda3, and `jupyterlab` is installed via Conda):
~~~
source ~/anaconda3/etc/profile.d/conda.sh
conda activate
~~~


## An alternative way to use the ATLAS Jupyter environment at SLAC

The above atlas/20210403 instance resides in a Singularity image. You can use it at anywhere as long as the host can access the following CVMFS file. For example, on cent7a.slac.stanford.edu, you can run this command by hand:

`singularity run --nv -B /cvmfs,/gpfs,/scratch,/nfs,/afs /cvmfs/atlas.sdcc.bnl.gov/jupyter/t3s/slac/singularity/jupyter-conda.20210403.sif`

When you see it prints out a line like the following,

`http://localhost:8888/?token=ec4d404fe69d2ff760d611c0509a9e8ac770c7f46ac32860`

then use `ssh -L 8888:localhost:8888 cent7a.slac.stanford.edu` to create a SSH tunnel. After this, paste the above URL in your browser to access your jupyter instance.

Note `centos7.slac.stanford.edu` is a DNS alias of several machines `cent7[a-d].slac.stanford.edu`. Do not use the DNS alias `centos7` in the above case, use `cent7[a-d]` instead.

## Kernels and extensions in the ATLAS Jupyter environment

The Jupyter environment provides several kernels and extensions. This includes:

1. python2 with pyroot and uproot. By default, <b>AnalysisBase,21.2.111</b> is loaded before the pyroot2 kernel is launched. To overwrite this, create a file [$HOME/notebooks/.user_setups](SLACuser_setups.txt) in your home directory (even if your home directory is in AFS)
2. ROOT C++. The ATLAS environment is set before the kernel is launched. The overwrite method is the same as the above. 
3. python3 with pyroot, uproot3/awkward and Dask.
4. python3 with pyroot, uproot3/awkward and [RAPIDS.AI](https://rapids.ai) packages (cuPy, cuDF, cuML, dask_cuda, etc.). Choose "# of GPUs" (at least 1) and "GPU type" before launching Jupyter.
5. python3 with pyroot, uproot3/awkward and TensorFlow(GPU) and Keras. Choose "# of GPUs" (at least 1) and "GPU type" before launching Jupyter. 
6. Terminal console for simple interactive use, e.g. file managements. It also include python2.7/python3, gcc/g++, gdb, make, cmake3, xrootd-clients, openssh-client, curl, vi, SLURM client tools, etc.
7. Markdown document editor and previewer. You can edit and preview in two tabs simultaneously. 

## Extend ATLAS JupyterLab Functionalities

Python's pip module allows users to add packages to the JupyterLab environment as they need. For example, one can use PYCUDA and DASK distributed scheduling with SLURM. Check out [this doc](SLACJupyterExtraFuncs.md) on how to do that.

## Getting help

Please use the following e-mail addresses to get help. The division below is not strict. Questions will be routed to appropriate staff members.
1. Use atlas-us-slac-acf@cern.ch for ATLAS specific questions and requestions, including ATLAS software related issues.
2. Use unix-admin@slac.stanford.edu for all other questions
