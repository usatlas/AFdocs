## Using the batch system at UChicago
The UChicago Analysis Facility uses `HTCondor` for batch workloads. 
In a nutshell, to submit a job you will need to create an `executable` script and a `submit` file that describes your job.
### Before submitting to the analysis facility

Before going mad submmiting jobs to the batch system, we have to check some points to consider when performing an analysis/work in the most efficient way and enhance the use of the available resources.
Be sure to understand them and remember that you can always ask. 

Check list before submitting:
<ul>
<li><input  disabled=" " type="checkbox"> Which filesystem should be used to submit my jobs?</li>
<li><input  disabled="" type="checkbox"> How much memory request does my Job(s) need?</li>
<li><input  disabled="" type="checkbox"> Should my job(s) be submitted to the short or the long queue?</li>
<li><input  disabled="" type="checkbox"> Check all my jobs requirements</li>
<li><input  disabled="" type="checkbox"> Always check my jobs status</li>
</ul>


-  #### Which filesystem to use
By default, all jobs start in the `$scratch/` directory on the worker nodes, this means you have to create the workflow for your jobs keeping in mind that they will start in the `$scratch` directory as soon as you submit your jobs and indicating every step that you yourself follow when running your jobs locally, (that also includes copying the data samples that you will run to the `$scratch` directory). Also, notice that your output data will need to be staged to the shared filesystem or it will be lost!, since the `$scratch/` area is ephemeral not for storage and it is not backed up.
When submitting jobs, you should try to use the local scratch filesystem whenever possible. This will help you be a "good neighbor" to other users on the system, and reduce overall stress on the shared filesystems, which can lead to slowness, downtimes, etc.


We added some examples to make this ideas clearer.

[example]()

Check the following example, data is read from `Rucio`, we pretend to process it, and then push a small output copied back to the `$HOME` filesystem. It assumes your X509 proxy certificate is valid and in your home directory.

We create our executable file:
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

- #### The Short and the Long queues.

Before submitting jobs you should have an idea about how long the job will take to finish (not the exact time but an approximate).
In `HTCondor` we added a a feature called `shortqueue` with dedicated workers that will ONLY service jobs that run for less than **4 hours**.
To make use of the shortqueue you just have to add the following configuration parameter to your job submit file.

```bash
+queue="short"
```
If your job is longer than 4 hours just exclude this configuration parameter from your submit file and your jobs will be sent to the `long-queue` automatically, otherwise your job will be placed on hold until you remove it or release it (check HTCondor commmands).

☆ﾟ.* Important: Using this -short queue- for -short jobs- when possible is essential for the use of the available resources, specially to let the -long queue- available for -long jobs-. *. ﾟ☆.

- #### Job memory request
How much memory does your job need to run? 

#### How to submit jobs
 You will need to define an executable script and a "submit" file that describes your job. A simple job that loads the ATLAS environment looks something like this:

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
### Configuring your jobs to use an X509 Proxy Certificate

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


### Check these points before using the Analysis Facility System

[]:#(table2  with filesystems differences) 
<table>
<thead>
<tr>
<th>Topic</th>
<th>Warning</th>
<th>Tips</th>
</tr>
</thead>
<tbody>
<tr>
<td>$home quota </td>
<td>Your quota at $HOME is 100GB,<br>be careful not to exceed this quota because some issues may arise,
<br>for example not being able to login next time.</td>
<td>- Use the command 'du -sh'
<br>    to know the actual  size of your current directory  
<br>- Check the table displayed at the start of your session,
<br>    which indicates the usage of your /home and /data directories.</td></tr>
<tr>
<td>-</td>
<td>-</td>
<td>-</td></tr>
</tbody>
</table>
