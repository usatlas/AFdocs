# Data Sharing at BNL

This guide covers data sharing methods available at BNL, including Xcache servers and accessing CERN EOS from BNL.

---

## Using the Xcache servers

Both BNL and SLAC have set up **Xcache servers** to help cache locally the files
on the grid or **CERN EOS**. Currently there are 60TB on the BNL Xcache server,
and 20TB on the SLAC Xcache server.

The Xcache servers:

- Provide **rucioN2N feature**, enabling users to access any files on the grid
  without knowing its exact site location and the file path.
- Help **cache locally** the content of remote files actually read in the first
  access, thus improves the read performance for sequential access. If only
  partial content of a file is read, then only that part would be cached.

You can run the predefined command **Xcache_ls.py** to generate a clist file
(containing a list of physical file paths) for given datasets, then use the
clist in your jobs.

### Using Xcache_ls.py

Run **Xcache_ls.py -h** to get the full usage:

```
% Xcache_ls.py -h
Usage:
     Xcache_ls.py [options] dsetNamePattern[,dsetNamePattern2[,more patterns]]
  or
     Xcache_ls.py [options] --eos eosPath/
  or
     Xcache_ls.py [options] --eos eosPath/filenamePattern
  or
     Xcache_ls.py [options] dsetListFile

  This script generates a list (clist) of
  Xcache gLFN (global logical filename) access path
  for given datasets on Atlas grid sites.
  Wildcard is supported in the dataset name pattern.

Options:
  -h, --help            show this help message and exit
  -v                    Verbose
  -V, --version         print my version
  -X XCACHESITE, --XcacheSite=XCACHESITE
                        Specify a Xcache server site of BNL or SLAC
                        (default=BNL)
  -o OUTCLISTFILE, --outClistFile=OUTCLISTFILE
                        write the list into a file instead of the screen
  --eos=EOS_PATH, --cerneos=EOS_PATH
                        List files (*.root and *.root.[0-9] on default) on
                        CERN EOS
  -d OUTCLISTDIR, --dirForClist=OUTCLISTDIR
                        write the list into a directory with a file per
                        dataset
```

!!! tip "Pre-staging large files"

    For large file inputs on the grid, you are recommended to plan ahead and pre-stage them to BNL using [R2D2 request](https://rucio-ui.cern.ch/r2d2/manage_quota) or rucio command.

---

## Work between BNL and CERN

### Access to CERN EOS from BNL

The ways to list, write and read files on CERN EOS, documented
[here](https://twiki.cern.ch/twiki/bin/view/AtlasComputing/ATLASStorageAtCERN#EOS_storage_system),
still work at BNL, but you need specify the full EOS server name
**eosatlas.cern.ch** and obtain a CERN Kerberos ticket.

You can obtain and cache a CERN Kerberos ticket (this is also required for the
way of using ssh-tunnel below) by:

```bash
kinit YourNameAtCERN@CERN.CH
```

!!! warning "CERN.CH must be uppercase"

    Please be aware that in the above command the realm **CERN.CH** must be in **UPPERCASE**.

As convenience for the US ATLAS users, we have installed the eos-client and
eos-fusex packages on the interactive nodes.

After obtaining your CERN Kerberos ticket, you can access both the **ATLAS EOS**
and **USER EOS** instances.

To list your files:

```bash
ls /eos/atlas/...
ls /eos/user/y/yesw/...
```

!!! note

    Please replace _"y/yesw"_ with your own username at CERN.

To copy files from EOS:

```bash
cp /eos/atlas/YourDir/YourFilename.root .
```

To copy files to your EOS area at CERN:

```bash
cp MyNewFile.xxx /eos/atlas/YourDir/MyNewFile.xxx
```

You can create new directories in your EOS area at CERN:

```bash
mkdir /eos/atlas/YourDir/NewDirectory
```

In addition, you can also use ssh-tunnel to **eosatlas.cern.ch**:

```bash
ssh -NfL 1094:eosatlas:1094 lxplus.cern.ch
```

Then you can list files on EOS:

```bash
xrdfs eosatlas.cern.ch ls /eos/atlas/..
xrdfs localhost ls /eos/atlas/..   # if using ssh-tunnel
```

To copy files from EOS:

```bash
xrdcp root://eosatlas.cern.ch//eos/atlas/YourDir/YourFilename.root .
xrdcp root://localhost//eos/atlas/YourDir/YourFilename.root .  # if using ssh-tunnel
```

Or you make use of the existing script **eos-copy.py**, which is an alias and
should have been defined for you upon login:

```bash
% which eos-copy.py
/afs/usatlas.bnl.gov/scripts/eos-copy.py

% eos-copy.py -h
Usage: eos-copy.py [options] eos_source... local_dir
   eos-copy.py [options] eos_source... pnfs_dir

     widlcard such as "*.root" is allowed in the eos_source.

   This script uses xrdcp to copy files/dirs from CERN EOS to a local dir
or a BNL private dCache dir. A valid CERN AFS token is required.


Options:
  -h, --help  show this help message and exit
  --verbose   Print verbose info
  --version   Print the script version then exit
```

Or to read EOS files in ROOT:

```cpp
TFile *file = TFile::Open("root://eosatlas.cern.ch//eos/atlas/YourDir/YourFilename.root");
TFile *file = TFile::Open("root://localhost//eos/atlas/YourDir/YourFilename.root");  // if using ssh-tunnel
```

### Access to CERN EOS in BNL batch jobs

The method using ssh-tunnel would not work in batch jobs, you need access them
directly with `root://eosatlas.cern.ch`. However, for protected EOS files, you
need pass your CERN Kerberos ticket to the batch machines in the following way:

1. First define one envvar **KRB5CCNAME** prior to running
   `kinit YourNameAtCERN@CERN.CH`:

   ```bash
   export KRB5CCNAME=$HOME/krb5cc_`id -u`
   ```

2. Then add the envvar **KRB5CCNAME** to your condor batch jobs.

### Access to CERN EOS through BNL Xcache server

If you need repeat access the same EOS files, you can make use of the BNL Xcache
server to speed up the reading speed for the sequential access.

Just use the option **--eos=EOS_PATH** in the script **Xcache_ls.py** to
generate the clist files for your EOS files at CERN. Please run **Xcache_ls.py
-h** for more details.

### Access to BNL files from CERN and outside BNL

You or your collaborators may need remote access to files at BNL.

#### Access to BNL dCache files from CERN

You can use the following scripts (**~yesw/public/bnl/bnl_pnfs-ls.py**) to
generate clist or list files under a given BNL /pnfs directory.

```
lxplus% ~yesw/public/bnl/bnl_pnfs-ls.py -h
Usage:
     bnl_pnfs-ls.py [-o clistFilename] [options] [pnfsFilePath | pnfsDirPath] [morePaths]

  This script generates pfn (physical file name), pnfs-path,
or xrootd-path of files on BNL dcache for given datasets or files on PNFS,
where wildcard is supported in pnfsFilePath and pnfsDirPath

Options:
  -h, --help            show this help message and exit
  -v                    Verbose
  -V, --version         print my version
  -l, --listOnly        list only matched datasets under users dCache, no pfn
                        output
  -o OUTPFNFILE, --outPfnFile=OUTPFNFILE
                        write pfn list into a file instead of printing to the
                        screen
```

For example, you run the above script in the following ways:

```bash
lxplus% ~yesw/public/bnl/bnl_pnfs-ls.py -l /pnfs/usatlas.bnl.gov/users/yesw2000/testDir2
lxplus% ~yesw/public/bnl/bnl_pnfs-ls.py -o my.clist /pnfs/usatlas.bnl.gov/users/yesw2000/testDir2
1  files listed into clist file= my.clist
```

You can use the generated clist file in your job in the following way:

```cpp
TChain* chain = new TChain(treeName);
TFileCollection fc("fc","list of input root files","my.clist");
chain->AddFileInfoList(fc.GetList());
```

#### Access to BNL other file systems from CERN

You can use **sshfs** to mount the remote BNL files to lxplus machines locally.
For example:

```bash
lxplus% mkdir /tmp/yesw/data
lxplus% sshfs attsub02:/atlasgpfs01/usatlas/data/yesw2000 /tmp/yesw/data
```

!!! note

    This assumes that you have already set up the ssh configuration as shown in [the section of interactive connection to BNL](accessing.md#ssh-connection-to-the-interactive-nodes).

To umount the mounted point, just run **fusermount -u /tmp/yesw/data**.

To list all the sshfs mounted points, just run **pgrep -a -f sshfs**.

#### Access to BNL other file systems from other remote computers

For other computers outside of BNL such as your laptop, you can use the same way
as that for CERN. You can find the instruction of sshfs installation on
different OS at
[https://linuxize.com/post/how-to-use-sshfs-to-mount-remote-directories-over-ssh/](https://linuxize.com/post/how-to-use-sshfs-to-mount-remote-directories-over-ssh/).
