# [The SLAC JupyterLab](https://sdf.slack.stanford.edu/public/doc/#/interactive-compute?id=jupyter)

## Table of contents

- [Login to JupyterLab at SLAC](#login-to-jupyterlab-at-slac)
- [How to launch JupyterLab at SLAC](#how-to-launch-jupyterlab-at-slac)
- [How to launch JupyterLab at SLAC](#how-to-launch-jupyterlab-at-slac)
- [Run your own Jupyter environment](#run-your-own-jupyter-environment)
- [Kernels and extensions in the ATLAS Jupyter environment](#kernels-and-extensions-in-the-atlas-jupyter-environment)
- [Extend ATLAS JupyterLab Functionalities](#extend-atlas-jupyterlab-functionalities)
- [Getting help](#getting-help)
<!--
- [An alternative way to start a Jupyter environment at SLAC](#an-alternative-way-to-start-a-jupyter-environment-at-slac)
  -->

## Login to JupyterLab at SLAC

Please refer to ["S3DF: a new ..."](../sshlogin/ssh2SLAC.md#accessing-to-s3df)
for information about logging in to
[SLAC Jupyter Web portal](https://s3df.slack.stanford.edu/ondemand), available
spaces and network constrains.

## How to launch JupyterLab at SLAC

Once you login to the main portal, click "My Interactive Sessions" from the top
menu bar. Then choose "Jupyter". You will need to make a few choices:

1. In "Jupyter Instance" box, choose "atlas/20210403". You can choose Jupyter
   Instances for other experiments but there is no guarantee that those
   instances will work for you. You can also bring your own Jupyter environment
   (under Custom)
2. Check the "Use JupyterLab instead of Jupyter Notebook?" box.
3. In the account box, type "atlas:usatlas".
4. In the "Partition" box, choose "rome" for CPU only session, or "ampere" if
   you need GPUs
5. Choose hours, # CPUs, memory, # GPUs and GPU type, then click "launch". Note
   that your Jupyter work runs as a SLURM job. So choose only what you need to
   ensure speedy launching of your job.

<!--
In addition to using this portal, it is also possible to directly run Jupyter
on SLAC batch nodes (see [section below](#an-alternative-way-to-start-a-jupyter-environment-at-slac))
-->

## Run your own Jupyter environment

The ATLAS instance we built may not satisfy your need. If you have your own
Jupyter environment that is accessible from SLAC (on SLAC disk or in CVMFS), you
may be able to run it on SLAC's Jupyter infrastructure. To do so:

1. Following the same steps above to launch Jupyter at SLAC.
2. Instead of choosing the "atlas-jupyter..." instance, you choose "Custom
   Singularity Image" or
   "[Custom Conda Environment](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html)".
3. The "Commands to initiate Jupyter" box will be pre-filled with commands to
   prepare your instance. You can edit/paste whatever Shell script to the box to
   prepare launching your Jupyter environment.
4. A backend launching script will "source" your Shell script. It expects that
   after "sourcing", there is a command (or Shell function) called "jupyter" for
   it to run. It will then run one of the following commands, `jupyter notebook`
   or `jupyter lab` (depend on whether you choose Jupyter Notebook or Jupyter
   Lab) to launch your Jupyter environment.
5. Below are example scripts to prepare for launching Jupyter from a Singularity
   container:

```
export SINGULARITY_IMAGE=/sdf/data/atlas/u/$(id -un)/.../my_singularity_image.sif
function jupyter() { singularity exec --nv -B /sdf,/cvmfs ${SINGULARITY_IMAGE} jupyter $@ }
```

or from a Conda environment (assuming Anaconda 3 is installed at ~/anaconda3,
and `jupyterlab` is installed via Conda):

```
source ~/anaconda3/etc/profile.d/conda.sh
conda activate
```

<!--
## An alternative way to start a Jupyter environment at SLAC

The SLAC Jupyter portal uses the Open OnDemand technology. In rare cases, Open OnDemand may run into
trouble. Fortunately the Slurm batch system at SLAC enables a user to SSH into a batch node if the user has a batch
job running on that
node. The feature makes it possible to for users to directly run Jupyter on batch nodes (bypassing Open OnDemand),
by following instruction below:

1\. Create a script to start your Jupyter environment. <p>
The following script can be used to start a Jupyter instance using one of the ATLAS image in CVMFS. You can write a
similar script to start your own Jupyter environment.
```
#!/bin/sh

hostname -f

op=exec
cmd="jupyter lab"
[ ! -z "$1" ] && cmd="$1"

export T3repo=/cvmfs/atlas.sdcc.bnl.gov/jupyter/t3s
#SINGULARITY_IMAGE_PATH=${T3repo}/slack/singularity/atlas-slack-w-slurm-cli-20200714.sif
#SINGULARITY_IMAGE_PATH=${T3repo}/slack/singularity/jupyter-miniforge.20220315.sif
SINGULARITY_IMAGE_PATH=${T3repo}/slack/singularity/jupyter-conda.20210403.sif
export SINGULARITY_IMAGE_PATH
singularity $op -B /cvmfs,/sdf,/gpfs,/scratch,/lscratch \
                -B /etc/slurm,/opt/slurm,/var/spool/slurmd,/run/slurm/conf/slurm.conf \
                -B /var/run/munge \
                -B /bin/modulecmd \
                -B ${T3repo}/slack/singularity/99-zatlas.sh:/.singularity.d/env/99-zatlas.sh \
                --nv \
            ${SINGULARITY_IMAGE_PATH} $cmd
```
Note that at the top of the script there is a `hostname -f` line. This is useful to tell which host (batch node)
the script is actually running on.

2\. Submit the script to Slurm
```
srun -J jupyter --nodes=1 <other_options> /bin/sh the_above_script
```
`other_options` can be
```
--cpus-per-task=N (number of CPU cores)
--mem=XXXX (memory in MB)
--time=XXXX (wall time in minutes, default is 30 minutes)
--gres='gpu:a100:1' (request a A100 GPU, or 'gpu:1' for any kind of GPU)
--account='shared' (or use account 'usatlas')
```
A word about Slurm `account`: SLAC has a large pool of GPUs, including 80x A100 GPUs and a few hundreds older
Nvidia GPU models. US ATLAS owns four A100 GPUs. 'usatlas' account will guaranty the usage, but you may be
competing with other US ATLAS colleagues. Jobs using 'shared' account are subject to preemption but the risk of
being preempted in a few hours is low (under the current usage pattern).

3\. Write down a few info from the above `srun` command.<p>
The command should first show the full hostname of the batch node it is running on (say
`the_batch_node.slack.stanford.edu`). It should also print out messages asking you to point your browser to an URL like:
```
http://localhost:8888/?token=ec4d404fe69d2ff760d611c0509a9e8ac770c7f46ac32860
```
Note the port number above is `8888`. Sometimes it is not `8888`.

4\. Setup a SSH tunnel between your desktop and the batch node to access Jupyter
```
ssh -L 8888:localhost:8888 -J <your_username>@sdf-login.slack.stanford.edu \
                              <your_username>@the_batch_node.slack.stanford.edu
```
Again, note that the port number may not be `8888`.

5\. Paste the above URL in your browser.

You are all set.
-->

## Kernels and extensions in the ATLAS Jupyter environment

The Jupyter environment provides several kernels and extensions. This includes:

1. python2 with pyroot and uproot. By default, <b>AnalysisBase,21.2.111</b> is
   loaded before the pyroot2 kernel is launched. To overwrite this, create a
   file [$HOME/notebooks/.user_setups](SLACuser_setups.txt) in your home
   directory (even if your home directory is in AFS)
2. ROOT C++. The ATLAS environment is set before the kernel is launched. The
   overwrite method is the same as the above.
3. python3 with pyroot, uproot3/awkward and Dask.
4. python3 with pyroot, uproot3/awkward and [RAPIDS.AI](https://rapids.ai)
   packages (cuPy, cuDF, cuML, Dask/Dask-CUDA, etc.). Choose "# of GPUs" (at
   least 1) and "GPU type" before launching Jupyter.
5. python3 with pyroot, uproot3/awkward and TensorFlow(GPU) and Keras. Choose "#
   of GPUs" (at least 1) and "GPU type" before launching Jupyter.
6. Terminal console for simple interactive use, e.g. file managements. It also
   include python2.7/python3, gcc/g++, gdb, make, cmake3, xrootd-clients,
   openssh-client, curl, vi, SLURM clients, etc.
7. Markdown document editor and previewer. You can edit and preview in two tabs
   simultaneously.

## Extend ATLAS JupyterLab Functionalities

Python's pip module allows users to add packages to the JupyterLab environment
as they need. For example, one can use PYCUDA and DASK distributed scheduling
with SLURM. Check out [this doc](SLACJupyterExtraFuncs.md) on how to do that.

## Getting help

Please use the following e-mail addresses to get help. The division below is not
strict. Questions will be routed to appropriate staff members.

1. Use atlas-us-slac-acf@cern.ch for ATLAS specific questions and requestions,
   including ATLAS software related issues.
2. Use unix-admin@slack.stanford.edu for all other questions
