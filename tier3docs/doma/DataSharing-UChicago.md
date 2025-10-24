# Data Sharing at UChicago: Work between UChicago and CERN

This guide covers how to access CERN EOS from UChicago, use the XCache server,
and manage authentication credentials for data access.

---

## Access to CERN-EOS from UChicago

!!! warning "EOS access from worker nodes"

    `/eos` is only mounted on the interactive (`login`) nodes. To access from worker nodes (e.g. condor jobs), we recommend the use of `xrootd` such as:

    ```bash
    root://eosuser.cern.ch//eos/user/d/dschrute/file.txt
    ```

    or via `xrdcp` inside your job:

    ```bash
    xrdcp root://eosuser.cern.ch//eos/user/d/dschrute/file.txt .
    xrdcp -r root://eosuser.cern.ch//eos/user/d/dschrute/many_files/ .
    ```

    as long as you [export your CERN Kerberos ticket](#cern-kerberos-ticket) to your HTCondor jobs.

The ways to list, write and read files on CERN EOS, documented
[here](https://twiki.cern.ch/twiki/bin/view/AtlasComputing/ATLASStorageAtCERN#EOS_storage_system),
still work at UChicago.

!!! note "setup-eos is deprecated"

    `setup-eos` has been deprecated in favor of using `kinit`.

On the Analysis Facility login servers, try the following:

```bash
kinit <cern_user>@CERN.CH
```

as described in [CERN Kerberos ticket](#cern-kerberos-ticket). To list your
files located at /eos/user/d/dschrute/:

```bash
ls /eos/user/d/dschrute
# remember to replace "d/dschrute" with your own username at CERN.
```

To create a new directory at /eos/user/d/dschrute/:

```bash
mkdir /eos/user/d/dschrute/new_dir
# remember to replace "d/dschrute" with your own username at CERN.
```

To copy files from /eos/user/d/dschrute/ to your current directory:

```bash
cp /eos/user/d/dschrute/file.txt .
# use `cp -r` if you need to copy a directory
```

To copy files from /eos/user/d/dschrute/ to any path within your profile:

```bash
cp /eos/user/d/dschrute/file.txt  $HOME/codingx/ # eg: /home/dschrute/codingx/
# use `cp -r` if you need to copy a directory
```

---

## Xcache at UChicago

UChicago Analysis Facility maintains an XCache server (managed through SLATE),
with 25 x 1.5 TB NVMes and 2x25 Gbps NIC.

ServiceX uses the XCache by default.

Users that want to access remote data of their own on EOS or elsewhere, can
manually add the prefix `root://192.170.240.18:1094//` to their root paths and
the prefix `:1094` to their server address, e.g.:

If the original path is:

```bash
root://someserver.org//atlaslocalgroupdisk/rucio/user/mgeyik/63/c4/user.mgeyik.26617246._000006.out.root
```

then make it:

```bash
root://192.170.240.18:1094//root://someserver.org:1094//atlaslocalgroupdisk/rucio/user/mgeyik/63/c4/user.mgeyik.26617246._000006.out.root
```

### Example

```bash
# Original path
root://eosatlas.cern.ch//eos/atlas/atlastier0/rucio/data_13TeV/physics1/data_13TeV.004345.physics_Main.eaq./data_13TeV.004345.physics_Main.eaq_0001.root

# make it:
root://192.170.240.18:1094//root://eosatlas.cern.ch:1094//eos/atlas/atlastier0/rucio/data_13TeV/physics1/data_13TeV.004345.physics_Main.eaq./data_13TeV.004345.physics_Main.eaq_0001.root
```

---

## CERN Kerberos ticket

You can obtain and cache a CERN Kerberos ticket (this is also required for the
way of using ssh-tunnel below) by doing:

!!! warning "CERN.CH must be uppercase"

    Please notice that the domain CERN.CH must be in UPPERCASE.

```bash
kinit <name_at_CERN>@CERN.CH
```

List your ticket:

```bash
klist
```

### Pass your CERN Kerberos ticket to your HTCondor jobs

Before running the previous command `kinit <name_at_CERN>@CERN.CH`, pass your
CERN Kerberos ticket to the batch machines:

```bash
export KRB5CCNAME=$HOME/krb5cc_`id -u` # this defines the environment variable `KRB5CCNAME`
```

Then add the environment variable KRB5CCNAME to your condor batch job, e.g.:

```bash
...
environment = <parameter_list>
...
x509userproxy  = $ENV(X509_USER_PROXY) # this adds KRB5CCNAME to your condor batch job.
```

---

## Always check your proxy certificate

If you are trying to use HTCondor driver to run some jobs that need data access
authorization, for example on `rucio`, always check the status of your proxy
grid certificate.

!!! warning "Proxy certificate expiration"

    Your x509proxy certificate has an expiry date. Once it expires you have to create an ATLAS VOMS proxy again in the usual way. You create (or copy it to) the shared $HOME filesystem so that the HTCondor scheduler can find and read the proxy.

This is how you copy it to $HOME:

```bash
voms-proxy-init -voms atlas -out $HOME/x509proxy
```

!!! important

    Without the term `-out $HOME/x509proxy` you create a new proxy but the one that maybe is already in your $HOME directory is still expired.

Once you renew your proxy certificate, add the following lines to your job
submit file so that HTCondor configures the job environment automatically for
x509 authenticated data access:

```bash
universe = vanilla

use_x509userproxy = true  # Required for x509 authentication
x509userproxy = /home/dschrute/x509proxy  # Path to your proxy certificate

request_memory = 1GB
request_cpus = 1
queue 1
```
