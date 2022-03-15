# [The BNL JupyterLab](https://atlas-jupyter.sdcc.bnl.gov)

## Table of Contents
+ [The JupyterHub resources on HTC cluster and HPC clusters](#the-jupyterhub-resources-on-htc-cluster-and-hpc-clusters)
+ [Kernels and extensions in the ATLAS Jupyter environment](#kernels-and-extensions-in-the-atlas-jupyter-environment)
+ [Getting help](#getting-help)

Before accessing [the BNL JupyterHub](https://atlas-jupyter.sdcc.bnl.gov) <https://atlas-jupyter.sdcc.bnl.gov/>, please [apply for a BNL computing account](../UserOnboarding/account/BNLFederatedID.md). BNL's Scientific Data Computing Center (SDCC) provides JupyterHub environment on their HTC (high throughput computing) cluster and HPC (high performance computing) clusters. Choose one of them to login.

## The JupyterHub resources on HTC cluster and HPC clusters

Jupyter instances running under the HTC JupyterHub are actually Condor batch jobs. Using HTC JupyterHub requires affiliation to an experiment, such as ATLAS.

Jupyter instances running under the HPC JupyterHub are run as SLURM batch jobs on either [BNL Institutional Cluster (IC)](https://www.racf.bnl.gov/experiments/sdcc/institutional-cluster/information) or [KNL cluster](https://www.racf.bnl.gov/experiments/sdcc/knl-cluster/information). Using HPC JupyterHub requires a valid time allocation on those clusters. Nvidia GPUs are available on the IC cluster and Intel Xeon Phi Knights Landing (KNL) CPU are available on the KNL cluster.

## Kernels and extensions in the ATLAS Jupyter environment

The Jupyter environment provides several kernels and extensions. This includes:

1. python2 with pyroot and uproot. By default, <b>AnalysisBase,21.2.111</b> is loaded before the pyroot2 kernel is launched. To overwrite this, create a file [$HOME/notebooks/.user_setups](SLACuser_setups.txt) in your home directory (even if your home directory is in AFS)
2. ROOT C++. The ATLAS environment is set before the kernel is launched. The overwrite method is the same as the above. 
3. python3 with pyroot and uproot. 
4. python3 kernerls with Tensorflow on CPU, Tensorflow on GPU and ML packages.
5. Terminal console for simple interactive use
6. Markdown document editor and previewer. You can edit and preview in two tabs simultaneously. 

## Getting help

>   Need help? Have questions or comments?, Visit our <img src="images/discourse.png" style="width:13px; height:13px" alt="Discourse Logo" /> [ATLAS AF Discourse Forum ](https://atlas-talk.sdcc.bnl.gov/) (do not confuse with Discord 👾) 
>    for user support, contact, friendly discussion, newsletter and more! We'd love to help you have a smooth experience while working at our analysis facilities!

<!---
Please use the following e-mail addresses to get help. The division below is not strict. Questions will be routed to appropriate staff members.
1. Use bnl-shared-tier3-l@lists.bnl.gov for ATLAS specific questions and requestions, including ATLAS software related issues.
2. Use rt-racf@bnl.gov for all other questions
-->