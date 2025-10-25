# SSH login and batch info at BNL

You can find [the main SDCC page](https://www.sdcc.bnl.gov)

## Interactive Connection to BNL

### ssh Connection to the interactive nodes

At BNL, you need login to `ssh.sdcc.bnl.gov` first, then login to interactive
machines attsub01, ..., attsub08 with command **ssh** or **"rterm -i"** without
argument (please refer to
[the following section for the rterm usage help](#Connect_to_the_interactive_n_AN1)
). You can add the following to file $HOME/.ssh/config on your laptop or local
machine, so you can login attsub\* machines directly.

>     host atlasgw
>          hostname ssh.sdcc.bnl.gov
>          user yourNameAtBNL
>
>     host attsub*
>        user yourNameAtBNL
>        proxycommand ssh atlasgw nc %h %p

Replace "yourNameAtBNL" with your own username at BNL. So you should be able to
run the following to login any machine such as attsub01 directly,

    ssh attsub01

Please note that: the **gateway** was just changed to **ssh.sdcc.bnl.gov**.

These nodes should be used for debugging and testing code. To run your complete
analysis code you should take advantage of
[the batch system](#Use_the_batch_system).

### File transfer from/to BNL machines

### Connection to NX servers at BNL

If you want to use a graphical environment, you can use
[NoMachine](https://www.nomachine.com/getting-started-with-nomachine) client to
connect to these NX servers, `nx.sdcc.bnl.gov`, which allows you to save/restore
sessions from anywhere anytime. Please visit
[the NoMachine (NX) page at BNL](https://www.sdcc.bnl.gov/information/services/how-use-nx-sdcc)
for details. Besides the connection through NoMachine client, you can also
connect to the new NX servers on web browsers, using the URL:
[https://nx.sdcc.bnl.gov](https://nx.sdcc.bnl.gov).

### Connect to the interactive nodes from NX

After you connect to the NX server, you can open a konsole terminal (depending
on the Window Manager you have chosen). From NX servers, you can run **rterm**
to ssh to other attsub machines on a separate **xterm** terminal. **rterm** will
help choose **the least loaded node**.

Please find the detailed usage of rterm by running the command **rterm -h**.

>     NX% rterm -h
>     term, V1.502 - Written by J. Lauret 2001
>     This command will open a connection to any remote node using the slogin
>     command and, without node precision open a terminal on the least loaded
>     node.
>
>     Syntax is
>       % rterm [Options] [NodeSpec] [UserName]
>
>     Currently implemented options are :
>       -i         interactive mode i.e. do not open an xterm but use slogin
>                  directly to connect.
>       -p port    use port number 'port' to connect
>       -x node    Exclude 'node' from possible node to connect to. May be
>                  a comma separated list of nodes.
>       -funky     pick a color randomly
>       -Y         use -Y option for ssh instead of -X
>
>     The 'NodeSpec' argument may be a node name (specific login to a given node)
>     or a partial node name followed by the '+' sign (wildcard). For example,
>       % rterm attsub+
>
>     will open a connection on the least loaded node amongst all batch-available
>     attsub* nodes. By default, this command will determine the appropriate
>     wildcarded node specification for your GroupID. However, if this help
>     is displayed when the command '% rterm' is used, contact the RCF support
>     team (your group ID is probably not supported by this script).
>
>     The 'UserName' argument is also optional. If unspecified, it will revert
>     to the current user ID.
>
>     Finally, you may modify the xterminal layout by using the following
>     environment variables
>       TERM_BKG_COLOR     sets the xterm background color
>       TERM_OPTIONS       sets any other xterm options

For example, you run define the envvar **TERM_OPTIONS** to pass the options the
executed command xterm.

    % export TERM_OPTIONS="-bg black -fg green -fn 10x20"
    % rterm

which will open a xterm terminal with the black background and green text color,
with the font size of 10x20.

### Setup ATLAS software environment

Once you are on the interactive nodes, you can simply run:

    setupATLAS

Please be aware that the executable or library built on Alma9 machines cannot
run on CentOS7 machines because of the system glibc library difference. To use
old CentOS7 releases, you can use [singularity](https://sylabs.io/singularity/)
to compile your package(s) within CentOS7 container. The command **setupATLAS -c
CentOS7** could help set up such a container, you would get something like:

>      ------------------------------------------------------------------------------
>     Info: /cvmfs mounted; do 'setupATLAS -d -c ...' to skip default mounts.
>     ------------------------------------------------------------------------------
>     Apptainer: 1.3.4
>     Host: Linux, AlmaLinux 9.5 (Teal Serval), x86_64, 5.14.0-503.19.1.el9_5.x86_64
>     From: /cvmfs/atlas.cern.ch/repo/containers/sw/apptainer/x86_64-el7/1.3.4/bin/apptainer
>     ContainerType: atlas-default
>     apptainer  exec  -e   -H /usatlas/u/yesw2000/.alrb/container/apptainer/home.XMrLKx:/alrb -B /cvmfs:/cvmfs -B /usatlas/u:/home -B /tmp/yesw:/srv /cvmfs/atlas.cern.ch/repo/containers/fs/singularity/x86_64-centos7 /bin/zsh
>     ------------------------------------------------------------------------------
>     lsetup               lsetup <tool1> [ <tool2> ...] (see lsetup -h):
>      lsetup agis          ATLAS Grid Information System
>      lsetup asetup        (or asetup) to setup an Athena release
>      lsetup atlantis      Atlantis: event display
>      lsetup eiclient      Event Index
>      [...]

Then it would behave like that you work on a CentOS7 machine.

## Use the batch system at BNL

### Condor batch system at BNL

RACF uses the Condor batch submission system. Detailed information about using
this system (submitting jobs, killing jobs, etc.) is described here:
[https://www.sdcc.bnl.gov/information/services/htcondor-sdcc](https://www.sdcc.bnl.gov/information/services/htcondor-sdcc).
You can also get the
[HTCondor Quick Start Guide](https://www.sdcc.bnl.gov/information/htcondor-quick-start-guide).

To see if you are on the list of authorized users to use the T3 batch system
consult this list of users:
[https://www.sdcc.bnl.gov/experiments/usatlas/list-users-institutes](https://www.sdcc.bnl.gov/experiments/usatlas/list-users-institutes)
You can also find your group information using the interactive command:
`whatgroup`.

If your name does not appear here, send an email to:
<RT-RACF-BatchSystems@bnl.gov>

After the batch system migration into the shared pool at BNL in March 2019, it
need not specify the group in the condor job description.

Since the upgrade of dCache in January 2019, xrootd access to dCache file would
require a valid grid proxy. You need specify **x509userproxy** in the job
description file with the following line:

    x509userproxy = $ENV(X509_USER_PROXY)

after you have generated a valid grid proxy in an interactive machine.

Please notice that the envvar **X509_USER_PROXY** has already been defined to
`$HOME/x509_u$UID` upon login. So actually you can also just pass all the env
including the evnvar **X509_USER_PROXY** to the condor jobs without specifying
**x509userproxy**, with the following line in the job description file:

    GetEnv          = True

In addition, please note that **rucio** is not recommended to be set up together
with Atlas releases because of possible conflict between them. You had better
use 2 separate sessions:

- One session with the rucio env, create grid proxy, and run rucio commands.
- The other session with one release env. submit condor jobs.

Or you could set up a rucio wrapper together with one release env, that is,

    lsetup "asetup AnalysiisBase,21.2.129" "rucio -w"

which set up both the release env of AnalysisBase,21.2.129 and a rucio wrapper,
which does not provide python API.

#### Use Condor within EventLoop

If you are using EventLoop to submit your code to the Condor batch system you
should replace your submission driver line with something like the following:

    EL::CondorDriver driver;
    job.options()->setString(EL::Job::optCondorConf, "getenv = true\naccounting_group = group_atlas.<institute>");
    driver.submitOnly( job, "yourJobName”);

You need replace the institute "&lt;institute&gt;" with your own institute (as
assigned by ACF) here.

#### Notice on using bash script in Condor

Please be aware that aliases will not be expanded by default within script. To
expand those aliases (such as **asetup**, **athena**), you need add the
following line to your script prior to running `setupATLAS`:

    shopt -s expand_aliases

### HPC cluster at BNL

- [Getting cluster allocation](https://www.sdcc.bnl.gov/information/services/obtaining-cluster-access) -
  how to apply for cluster allocation for your project
- [Accessing clusters through the gateway](https://www.sdcc.bnl.gov/information/getting-started/accessing-clusters-through-gateway) -
  SSH gateways for SDCC cluster access
- [Slurm Workload Manager](https://www.sdcc.bnl.gov/information/services/slurm-workload-manager) -
  guides for Slurm access and usage
