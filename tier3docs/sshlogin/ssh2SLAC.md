<style>
  #introMore {display: none;}
  #acctsMore {display: none;}
</style>

<script type="text/javascript" src="/tier3docs/scripts/readMoreOrLess.js"></script>

# S3DF: a new computing environment at SLAC

For decades, SLAC runs a high throughput computing (HTC) environment, primarily serving the HEP community. This
environment feature AFS file system home directory and LSF batch system, along with CVMFS. This environment is 
also known as the AFS environment.

SLAC is now building a new computing environment: the SLAC Shared Scientific Data Facility (S3DF). The core 
componments of S3DF are an interative pool, an OpenOnDemain web portal, a high throughput computer cluster
(HTC), with a subset being a HPC cluster and a GPU cluster - both managed by a single SLURM batch system, 
and storage clusters

## Accessing to S3DF

There are two ways to login to S3DF. 

- <b>SSH login</b> (using SLAC Unix password)
    1. Login to the bastion host `ssh <username>@s3dflogin.slac.stanford.edu`
    2. Then login to the actual interactive pool node `ssh iana` to do your work.
- <b>Login to S3DF web portal</b>
    - Go to https://s3df.slac.stanford.edu/ondemand and login to via Jupyter or a terminal. You will land on a 
  batch node.


S3DF also have a few data trasnfer nodes (s3dfdtn.slac.stanford.edu) for interactive data transfers. Note that 
all nodes in S3DF, except the bastion nodes and DTN nodes above, are in private network IP space. There are limited
NAT capacity to reach to the outside from these interactive and batch nodes. There is no inbound network connection 
to the interactive and batch nodes.

### OS enviornment

S3DF currently runs RHEL-8. However, ATLAS recommanded OS is AlmaLinux 9 (and previously RHEL7/CentOS7). Apptainer
container package is available on all S3DF nodes to help users who need to run their codes under a different OS 
environment. For example, to bring up an ATLAS provided AlmaLinux 9 environment in a container on an interactive node:

1. Add the following to `$HOME/.bashrc` and re-login
```
  function setupATLAS()
  {
    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    export ALRB_CONT_CMDOPTS="-B /sdf,/fs"
    source $ATLAS_LOCAL_ROOT_BASE/user/atlasLocalSetup.sh $@
    return $?
  }
```
2. Start an ATLAS environment in an AlmaLinux 9 container
```
  setupATLAS -c el9
```
For more info on this topic, especially how to do this in batch jobs, please refer to 
[ATLAS Canada Twiki](https://twiki.atlas-canada.ca/bin/view/AtlasCanada/Containers)

### Submitting SLURM jobs

All US ATLAS users can submit batch jobs using Slurm account <b>atlas:usatlas</b>, e.g. 
`srun -A atlas:usatlas hostname`. The partition to use is `roma` (an HPC cluster with AMD EPYC 7702 CPUs)
and `ampere` (a Nvidia A100 GPU cluster). The following is a typical script to be used with the `sbatch` command:

```
#!/bin/bash
#
#SBATCH --account=atlas:usatlas
#SBATCH --partition=ampere
#SBATCH --gpus a100:1
#SBATCH --job-name=my_first_job
#SBATCH --output=output-%j.txt
#SBATCH --error=output-%j.txt
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem-per-cpu=4g
#SBATCH --time=0-00:10:00

unset KRB5CCNAME  # <-- this is important

export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase

# Use ALRB_CONT_CMDOPTS to provide bind mount, etc. options
export ALRB_CONT_CMDOPTS="-B /sdf,/fs,/lscratch"

# Use ALRB_CONT_RUNPAYLOAD to define the actual job payload
export ALRB_CONT_RUNPAYLOAD="source $HOME/myJobPayload.sh”

# Run the payload in container.
source $ATLAS_LOCAL_ROOT_BASE/user/atlasLocalSetup.sh -c el9 –pwd $PWD

```

Note that S3DF currently disabled submitting to multiple partitions (due to issues with SLURM accounting). So
please avoid submitting jobs using multiple partitions (e.g. `#SBATCH --partition=roma,ampere`).

### Setup ATLAS environment

A typical way to setup ATLAS environment upon login is to put the following in $HOME/.bashrc. This is the same
at both AFS and SDF.
<!--
export ALRB_localConfigDir=/gpfs/slac/atlas/fs1/sw/localconfig
-->
```
export RUCIO_ACCOUNT="change_me"
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
alias setupATLAS='source $ATLAS_LOCAL_ROOT_BASE/user/atlasLocalSetup.sh'
...
```

## Available Storage

On the storage side, S3DF provides 
<ol>
  <li> Several  Weka parallel Posix file systems for user home and data. At the backend and , 
invisible and transparent to the users, each of these storage system consists of a NVMe cache of a few PB, 
and a spinning disk backed CEPH s3 object storage. All the file system metadata reside in the NVMe cache. 
  <li> The S3DF also mounted a Lustre file system that was previously used by the SDF system (S3DF's predecesssor). 
  <li> GPFS and AFS from the older faclities are mounted read-only on a few interactive login nodes to facilitate 
data migration
  <li> CVMFS is availble on all interactive and batch nodes.
</ol>

<!--
For ATLAS users, we currently provide GPFS filesystem for home (100GB) and data (2-10TB) in the AFS environment 
(under /gpfs/slac/atlas/fs1/{u,d} respectively). 
At SDF, ATLAS users will get a new home directory of 25GB. The GPFS file system is also available in SDF until 
the hardware retires (at that time, we will migrate users from GPFS to Lustre). AFS file system is not available 
in SDF.
-->

### Space available to the ATLAS users

The following spaces are available to ATLAS users:
<ol>
  <li> $HOME: quota 25GB on Weka file system
  <li> /sdf/data/atlas/u/&lt;username>: quota 200GB on Weka file system
  <li> /sdf/scratch/&lt;username_intial>/&lt;username>: quota 100GB on Weka file system. This is a scratch space. Data 
are subject to purge when the total scratch space is full.
  <li> /fs/ddn/sdf/group/atlas/d/&lt;username>: create your own dir please. This is a Lustre file system (it is also 
available in the old SDF facility at /sdf/group/atlas/d). It is fast
for bulk data access, but is not suitable for software. There is currently no easy way to enforce quota on this 
file system. Please try to keep your usage under 2TB if possible <p>
  <li> /sdf/group/atlas: quota 10TB on Weka file system shared by all users, for groups to storage software but not data.
(Note that this is a new space at S3DF. It has nothing to do with the above SDF space /sdf/group/atlas)
  <li> /sdf/scratch/users/&lt;username_initial>/&lt;<username>: 100GB scratch space, subject to purging.
  <li> /sdf/scratch/atlas: 5TB shared scratch space, subject to purging.
  <li> /lscratch on batch nodes, 300GB-7TB (depend on nodes). 
</ol>

For existing users, you may notice that the old AFS and GPFS spaces are no longer availalb at S3DF (except read-only
on a few interactive nodes). AFS and GPFS will be decommissioned soon at SLAC. Please move your data in AFS and 
GPFS space to the above spaces. 

The best tool to copy your data from AFS/GPFS to S3DF spaces is probaly the unix `cp -r -p` command. `rsync` is also a 
good and easy to use tool. Copying data may take days. So you may want to run your `cp` or `rsync` inside a `screen`
session. 

### Migration from older faculity to S3DF

Please refer to the following slides for plan and resentation about the migration.

1. [User data migration plan](https://docs.google.com/document/d/1-4YHRG2AswbJiBRP5EkWK86VPXW_x2HfWFrpTyTy5VA/edit?usp=sharing)
2. [Presentation at the SLAC ATLAS Group Meeting 2024-02-16](https://docs.google.com/presentation/d/1Hl1gDhSL8K0YFNVLHLm95a6Uo3p8SoCjdhhNQpg1gwY/edit?usp=sharing)

# Old obsolete systems

The following describe the soon to be obsolete systems, SDF and older AFS/LSF facilities. Please migrate to S3DF ASAP
as SLAC has set a deadline to decommission most of the services in these two older facilities around April 2024.

## <a name="sdf"></a>SSH login to SDF

`ssh <username>@sdf-login.slac.stanford.edu`

SLAC has two different computer accounts, unix and Windows. Please use your Windows account password to login. 
You may ask: What if I only have a unix account, and do not have a SLAC Windows account? Continue reading.

SDF uses a new identity management system (aka <span style="color:red">"SLAC ID"</span> - it will be a 
computer account to login to everything at SLAC). If you already have a SLAC Windows account, you are all 
set (SLAC ID = SLAC Windows account) and go to the next step. If you don't have a SLAC Windows account, 
please go to [SLAC SDF page and click 
"Accounts Portal"](https://sdf.slac.stanford.edu/public/doc/#/accounts-and-access?id=access). 
After this, give it a hour for the changes to be proprogated through SLAC computing.

## Submit SLURM batch job at SDF

The above URL is actually [the main page of SDF](https://sdf.slac.stanford.edu) (login info at the upper half
of the page, and user document at the lower half of the page). At there you can also find [the basic info about
using SLURM batch system](https://sdf.slac.stanford.edu/public/doc/#/batch-compute?id=using-slurm). One of the
lines in the example SLURM submission script, `#SBATCH --partition=shared` 
allows you to specify "shared" or "usatlas". 

ATLAS owns a small 
fraction of CPU resource in SDF. "usatlas" will give you guranteed access to ATLAS owned CPUs but you may have 
to wait if other ATLAS users are using them. "shared" allows you to access a large pool of CPUs (own by others)
so the waiting time will likely be shorter. But there is small risk that your job will be pre-emptied. 
The rule of thumb is to run short 
jobs in "shared", and run long jobs (12h+) in "usatlas".

To request a GPU, add "#SBATCH --gpus=1" to the submission script. All installed GPUs are Nvidia CUDA GPUs. Since
ATLAS currently does not own a GPU at SDF, you will need to use `#SBATCH --partition=shared` if you request
a GPU.

## SSH login to the AFS environment and submit LSF batch jobs

`ssh <username>@centos7.slac.stanford.edu`

You should use unix account password to login. Note that as 
SLAC retires the AFS environment in the next few years, this type of account (unix) may disappear.

The following page has many useful info about using the AFS environment, esepecially with regard to using the LSF
batch system. 

https://confluence.slac.stanford.edu/display/Atlas/SLAC+Analysis+Computing+Facility

## Remote X-windows access

SLAC currently provides [Fast-X](https://confluence.slac.stanford.edu/display/SCSPub/FastX) for accelerated 
X-window access. Fast-X maybe useful when you are far away from SLAC (geographically, or over a high latency network)
and you want to diaply your ROOT 2-D or 3-D/scatter plot.
You should use SLAC unix username and password to login to Fast-X. Once you are on Fast-X, you can 
`ssh -Y` to SDF or AFS login nodes.

Note that upon login to Fast-X, you may find some space that you can save a few files. Do NOT 
use this space for anything. This space is not your main GPFS or Lustre storage, it is not accessible from 
the AFS or SDF environment. It is also subject to deletion without notice.


SLAC is investigating [NoMachine](https://www.nomachine.com) as a replacement of Fast-X.

