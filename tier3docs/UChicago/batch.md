# Batch System at UChicago

The UChicago Analysis Facility uses
[HTCondor](https://htcondor.readthedocs.io/en/latest/users-manual/index.html)
for batch workloads. In a nutshell, to submit a job you will need to create an
executable script and a submit file that describes your job.

## Before submitting to the Analysis Facility

Before submitting a large number of tasks to the batch system, it is important
to understand a few things about your workloads and how they might best fit the
available resources of the Analysis Facility.

Some prerequisites to consider before submitting workloads to the Analysis
Facility:

- [ ] Which filesystem should be used to submit my jobs?
- [ ] Should my job(s) be submitted to the short or the long queue?
- [ ] How much memory request does my Job(s) need?
- [ ] Check all my jobs requirements
- [ ] Always check my jobs status

### Which filesystem to use

Your account on the UChicago Analysis Facility will be allocated space on the
`$HOME` and `$DATA` filesystems when your account is approved. By default, we
give each user 100GB of storage on the `$HOME` filesystem (i.e.,
`/home/<username>`). This filesystem is backed up weekly and is more optimized
for small files such as job logs, submit files, code and so on.

Data files, on the other hand, should be placed in the `$DATA` filesystem
(`/data/<username>`) which is more suitable for large files but is **not**
backed up. By default, you will be given a 5TB quota on this filesystem. If you
are working on an analysis that requires more local storage, please
[contact the UChicago facility team](../getting_help.md#facility-specific-support)
and we'll do our best to accommodate your request.

Finally, jobs submitted to HTCondor will be assigned to a server with one or
more dedicated high-speed "scratch" disks to use as working space when
processing your jobs, each with a few TB of available space. This is important
for two reasons:

- The scratch disk is _local_. We strongly recommend that you copy your input
  data from `$DATA` to `$SCRATCH` when running a job because this will generally
  deliver the best performance.
- The scratch disk is _ephemeral_. HTCondor will automatically clean up the
  scratch disk for the next workload when your job has finished using it.

/// warning | Don't lose your data!

With this in mind, you will need to make sure that you copy your output data
away from the `$SCRATCH` filesystem and into the `$DATA` filesystem at the end
of your job. Any data left in `$SCRATCH` will be lost at the end of your job!
When submitting jobs, you should try to use the scratch disk whenever possible.
This will help you be a "good neighbor" to other users on the system, and reduce
overall stress on the shared filesystems, which can lead to slowness, downtimes,
etc.

///

To summarize, please review the following table:

| Filesystem | Best for ...                  | Backup | Access from ...    | Default Quota |
| ---------- | ----------------------------- | ------ | ------------------ | ------------- |
| $HOME      | Code, Logs, Submit files      | Weekly | SSH, Jupyter, Jobs | 100GB         |
| $DATA      | ROOT files, other large files | None   | SSH, Jupyter, Jobs | 5TB           |
| $SCRATCH   | Transient job files           | None   | Jobs only          | No quota      |

Consider the following example: Data is read from Rucio, we pretend to process
it, and then push a small output back to the `$DATA` filesystem. It assumes your
X509 proxy certificate is valid and in your home directory.

We create our executable file:

```bash
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
cp AOD.11071822._001488.pool.root.1 $DATA/myjob.output
sleep 300
```

Followed by our submission file:

```
Universe = vanilla

Output = myjob.$(Cluster).$(Process).out
Error = myjob.$(Cluster).$(Process).err
Log = myjob.log

Executable = myjob.sh

use_x509userproxy = true
x509userproxy = /home/<username>/x509proxy

request_memory = 1GB
request_cpus = 1

Queue 1
```

It gets submitted in the usual way:

```
$ condor_submit myjob.sub
Submitting job(s).
1 job(s) submitted to cluster 17.
```

### The Short and the Long queues

Before submitting jobs you should have an idea about how long the job will take
to finish (not the exact time but an approximate). In `HTCondor` we added a
feature called `shortqueue` with dedicated workers that will ONLY service jobs
that run for less than **4 hours**. To make use of the shortqueue you just have
to add the following configuration parameter to your job submit file.

```bash
+queue="short"
```

If your job is longer than 4 hours just exclude this configuration parameter
from your submit file and your jobs will be sent to the `long-queue`
automatically, otherwise your job will be placed on hold until you remove it or
release it (check HTCondor commands).

/// important | Use the short queue for short jobs

Using the short queue for short jobs when possible is essential for the use of
the available resources, specially to let the long queue available for long
jobs.

///

### Job memory request

How much memory does your job need to run?

## How to submit jobs

You will need to define an executable script and a "submit" file that describes
your job. A simple job that loads the ATLAS environment looks something like
this:

Job script, called `myjob.sh`:

```bash
#!/bin/bash
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
export ALRB_localConfigDir=$HOME/localConfig
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh
# at this point, you can lsetup root, rucio, athena, etc..
```

Submit file, called `myjob.sub`:

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

The `condor_submit` command is used to queue jobs:

```
$ condor_submit myjob.sub
Submitting job(s).
1 job(s) submitted to cluster 17.
```

And the `condor_q` command is used to view the queue:

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

If you need to use an X509 Proxy, e.g. to access ATLAS Data, you will want to
copy your X509 certificate to the Analysis Facility. If you need a reminder,
information can be found in
[this link](https://twiki.cern.ch/twiki/bin/view/AtlasComputing/WorkBookStartingGrid).

Store your certificate in `$HOME/.globus` and create a ATLAS VOMS proxy in the
usual way:

```bash
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
export ALRB_localConfigDir=$HOME/localConfig
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh
lsetup emi
voms-proxy-init -voms atlas -out $HOME/x509proxy
```

You will want to generate the proxy on, or copy it to, the shared $HOME
filesystem so that the HTCondor scheduler can find and read the proxy. With the
following additions to your jobscript, HTCondor will configure the job
environment automatically for X509 authenticated data access:

```
use_x509userproxy = true
# Replacing <username> with your own username
x509userproxy = /home/<username>/x509proxy
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

## Check these points before using the Analysis Facility System

/// warning | $HOME quota

Your quota at $HOME is 100GB. Be careful not to exceed this quota because some
issues may arise, for example not being able to login next time.

**Tips:**

- Use the command `du -sh` to know the actual size of your current directory
- Check the table displayed at the start of your session, which indicates the
  usage of your /home and /data directories

///

---

## HTCondor user's guide

### Use condor within eventloop

If you are using EventLoop to submit your code to the Condor batch system you
should replace your submission driver line with something like the following:

```cpp
EL::CondorDriver driver;
job.options()->setString(EL::Job::optCondorConf, "getenv = true\naccounting_group = group_atlas.<institute>");
driver.submitOnly( job, "yourJobName");
```

### Useful attributes for the jobs submission file

| Option                  | What is it for?                                                                                                                                                                                                                                                                                                                                                                        |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| transfer_output_files=  | When it isn't specified, it automatically transfers back all files that have been created or modified in the job's temporary working directory.                                                                                                                                                                                                                                        |
| transfer_input_files    | HTCondor transfer input files from the machine where the job is submitter to the machine chosen to execute the job                                                                                                                                                                                                                                                                     |
| when_to_transfer_output | <ul><li>on_exit: (default) when the job ends on its own</li><li>on_exit_or_evict: if the job is evicted from the machine</li></ul>                                                                                                                                                                                                                                                     |
| should_transfer_files   | <ul><li>yes: always transfer files to the remote working directory</li><li>if_needed: (default) access the files from a shared file system if possible, otherwise it will transfer the file</li><li>no: disables file transfer</li><li>command specifies whether HTCondor should assume the existence of a file system shared by the submit machine and the execute machine.</li></ul> |
| arguments               | options passed to the exe from the cmd line                                                                                                                                                                                                                                                                                                                                            |
| periodic_remove=time    | <ul><li>remove a job that has been in the queue for more than 100 hours e.g. (time() - QDate) > (100*3600)</li><li>remove jobs that have been running for more than two hours e.g. periodic_remove = (JobStatus == 2 ) && (time() - EnteredCurrentStatus) > (2*3600)</li></ul>                                                                                                         |
| queue                   | indicates to create a job                                                                                                                                                                                                                                                                                                                                                              |

### Useful commands to manage and check the job's status

| Command                    | Description                                                                                                                      | Example |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------- |
| condor_hold                | Put jobs in the queue into the hold state                                                                                        | -       |
| condor_dagman              | Meta scheduler for the HTCondor jobs within a DAG (directed acyclic graph) or multiple DAGs                                      | -       |
| condor_release             | Releases jobs from the HTCondor job queue that were previously placed in hold state                                              | -       |
| condor_ssh_to_job JobId    | Creates an ssh session to a running job                                                                                          | -       |
| condor_submit –interactive | Sets up the job environment and input files. It gives a command prompt where you can then start job manually to see what happens | -       |
| condor_q                   | Display information about your jobs in queue                                                                                     | -       |
| condor_qedit               | To modify job attributes. Check condor_q -long; condor_qedit Cmd = path_to_executable #changes it                                | -       |
| condor_q -long             | Check job's ClassAd attributes to edit the attributes                                                                            | -       |
| condor_q -analyze 27497829 | Determines why certain jobs are not running                                                                                      | -       |
| condor_q -hold 16.0        | Reason job 16.0 is in the hold state                                                                                             | -       |
| condor_q -hold user        | retrieves: ID, OWNER, HELD_SINCE, HOLD_REASON                                                                                    | -       |
| condor_q -nobatch          | retrieves: ID, OWNER, SUBMITTED, RUN_TIME, ST, PRI, SIZE, CMD                                                                    | -       |
| condor_q -run              | retrieves: ID, OWNER, SUBMITTED, RUN_TIME, HOST(S)                                                                               | -       |
| condor_q -factory -long    | Factory information and the jobMaterializationPauseReason attribute                                                              | -       |
| condor_tail xx.yy          | Displays the last bytes of a file in the sandbox of a running job                                                                | -       |

---

## Using Docker / Singularity containers (Advanced)

Some users may want to bring their own container-based workloads to the Analysis
Facility. We support both Docker-based jobs as well as Singularity-based jobs.
Additionally, the CVMFS repository unpacked.cern.ch is mounted on all nodes.

If, for whatever reason, you wanted to run a Debian Linux-based container on the
Analysis Facility, it would be as simple as the following Job file:

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

Similarly, if you would like to run a Singularity container, such as the ones
provided in the unpacked.cern.ch CVMFS repo, you can submit a normal vanilla
universe job, with a job executable that looks something like the following:

```bash
#!/bin/bash
singularity run -B /cvmfs -B /home /cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlas/rucio-clients:default rucio --version
```

Replacing the `rucio-clients:default` container and `rucio --version` executable
with your preferred software.
