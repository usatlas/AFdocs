## Logging in to the UChicago Analysis Facility

First you will need to sign up on the [Analysis Facility website](https://af.uchicago.edu)

Please use your institutional or CERN identity (lxplus username) when signing up, as this will make the approval process smoother.

As part of signing up you will need to upload an SSH Public Key.

If you are not sure if you have generated an SSH Public Key before, try the following command (Mac/Linux) on your laptop to print the content of the file that contains the SSH Public Key:

```
cat ~/.ssh/id_rsa.pub
```

If the file exists, you should be able to copy the contents of this file to your profile on the AF website. **`Important!: Do not copy the contents of a file that does not end in .pub. You must only upload the public (.pub) part of the key.`**



If you do not have a public key (the file doesn't exist), you can generate one via the following command (Mac/Linux):

```
ssh-keygen -t rsa
```

Upload the resulting public key (ending in .pub) to your profile.

Once you have uploaded a key, it will take a little bit of time to process your profile and add your account to the system. After 10-15 minutes, you ought to be able to login via SSH:
```
ssh <username>@login.af.uchicago.edu
```
If it does not work, please double check that you have been approved, have a public key uploaded and have waited at least 15 minutes. If you still have an issue, feel free to reach out to us for help.
## Submitting to the Analyis Facility

The UChicago Analysis Facility uses HTCondor for batch workloads. You will need to define an executable script and a "submit" file that describes your job. A simple job that loads the ATLAS environment looks something like this:

Job script, called myjob.sh:

```
#!/bin/bash
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
export ALRB_localConfigDir=$HOME/localConfig
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh
# at this point, you can lsetup root, rucio, athena, etc..
```
Submit file, called myjob.sub:
```
Universe = vanilla

Output = myjob.$(Cluster).$(Process).out
Error = myjob.$(Cluster).$(Process).err
Log = myjob.log

Executable = myjob.sh

request_memory = 1GB
request_cpus = 1

Queue 1
```
The condor_submit command is used to queue jobs:
```
$ condor_submit myjob.sub
Submitting job(s).
1 job(s) submitted to cluster 17.
```
And the condor_q command is used to view the queue:
```
[lincolnb@login01 ~]$ condor_q


-- Schedd: head01.af.uchicago.edu : <192.170.240.14:9618?... @ 07/22/21 11:28:26
OWNER    BATCH_NAME    SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
lincolnb ID: 17       7/22 11:27      _      1      _      1 17.0

Total for query: 1 jobs; 0 completed, 0 removed, 0 idle, 1 running, 0 held, 0 suspended
Total for lincolnb: 1 jobs; 0 completed, 0 removed, 0 idle, 1 running, 0 held, 0 suspended
Total for all users: 1 jobs; 0 completed, 0 removed, 0 idle, 1 running, 0 held, 0 suspended
```
## Configuring your jobs to use an X509 Proxy Certificate

If you need to use an X509 Proxy, e.g. to access ATLAS Data, you will want to copy your X509 certificate to the Analysis Facility.

Store your certificate in ```$HOME/.globus``` and create a ATLAS VOMS proxy in the usual way:
```
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
export ALRB_localConfigDir=$HOME/localConfig
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh
lsetup emi
voms-proxy-init -voms atlas -out $HOME/x509proxy
```
You will want to generate the proxy on, or copy it to, the shared $HOME filesystem so that the HTCondor scheduler can find and read the proxy. With the following additions to your jobscript, HTCondor will configure the job enviroment automatically for X509 authenticated data access:
```
use_x509userproxy = true
x509userproxy = /home/YOURUSERNAME/x509proxy
```
E.g., in the job above for the user lincolnb:
```
Universe = vanilla

Output = myjob.$(Cluster).$(Process).out
Error = myjob.$(Cluster).$(Process).err
Log = myjob.log

Executable = myjob.sh

use_x509userproxy = true
x509userproxy = /home/lincolnb/x509proxy

request_memory = 1GB
request_cpus = 1

Queue 1
```
## Using Analysis Facility Filesystems

The UChicago analysis faciltiy has three filesystems that you should be aware of when running workloads. The table below describes their differences:


| Filesystem| 	Quota |	Path          | Backed up ?|  Notes                                                 |
| ----------|---------| --------------|------------|--------------------------------------------------------|                                                  
| $HOME     |	100GB   |	/home/$USER 	|Yes 	       | Solid-state filesystem, shared to all worker nodes     |
| $DATA     |	10 TB   |	/data/$USER 	|No 	       | CephFS filesystem, shared to all worker nodes          |
| $SCRATCH  | 	n/a 	| /scratch 	    |No 	       | Ephemeral storage for workloads, local to worker nodes |


When submitting jobs, you should try to use the local scratch filesystem whenever possible. This will help you be a "good neighbor" to other users on the system, and reduce overall stress on the shared filesystems, which can lead to slowness, downtimes, etc. By default, jobs start in the $SCRATCH directory on the worker nodes. Output data will need to be staged to the shared filesystem or it will be lost!

In the following example, data is read from Rucio, we pretend to process it, and then push a small output copied back to the $HOME filesystem. It assumes your X509 proxy certificate is valid and in your home directory.

```
#!/bin/bash
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
export ALRB_localConfigDir=$HOME/localConfig
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh
lsetup rucio
rucio --verbose download --rse MWT2_DATADISK data16_13TeV:AOD.11071822._001488.pool.root.1


# You can run things like asetup as well
asetup AnalysisBase,21.2.81

# This is where you would do your data analysis via AnalysisBase, etc. We will
# just pretend to do that, and truncate the file to simulate generating an
# output file. This is definitely not what you want to do in a real analysis!
cd data16_13TeV
truncate --size 10MB AOD.11071822._001488.pool.root.1
cp AOD.11071822._001488.pool.root.1 $HOME/myjob.output
```

It gets submitted in the usual way:
```
Universe = vanilla

Output = myjob.$(Cluster).$(Process).out
Error = myjob.$(Cluster).$(Process).err
Log = myjob.log

Executable = myjob.sh

use_x509userproxy = true
x509userproxy = /home/lincolnb/x509proxy

request_memory = 1GB
request_cpus = 1

Queue 1
```
```
$ condor_submit myjob.sub
Submitting job(s).
1 job(s) submitted to cluster 17.
```
## Using Docker / Singularity containers (Advanced)

Some users may want to bring their own container-based workloads to the Analysis Facility. We support both Docker-based jobs as well as Singularity-based jobs. Additionally, the CVMFS repository unpacked.cern.ch is mounted on all nodes.

If, for whatever reason, you wanted to run a Debian Linux-based container on the Analysis Facilty, it would be as simple as the following Job file:
```
universe                = docker
docker_image            = debian
executable              = /bin/cat
arguments               = /etc/hosts
should_transfer_files   = YES
when_to_transfer_output = ON_EXIT
output                  = out.$(Process)
error                   = err.$(Process)
log                     = log.$(Process)
request_memory          = 1000M
queue 1
```
Similarly, if you would like to run a Singualrity container, such as the ones provided in th unpacked.cern.ch CVMFS repo, you can submit a normal vanilla universe job, with a job executable that looks something like the following:
```
#!/bin/bash
singularity run -B /cvmfs -B /home /cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlas/rucio-clients:default rucio --version
```
Replacing the ```rucio-clients:default``` container and ```rucio --version``` executable with your preferred software.
