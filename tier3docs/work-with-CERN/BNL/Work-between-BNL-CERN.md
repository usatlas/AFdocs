# Work between BNL and CERN

## <span id="Access_to_CERN_EOS_from_BNL"></span> Access to CERN EOS from BNL

The ways to list, write and read files on CERN EOS, documented
[here](https://twiki.cern.ch/twiki/bin/view/AtlasComputing/ATLASStorageAtCERN#EOS_storage_system),
still work at BNL, but you need specify the full EOS server name
**eosatlas.cern.ch** and obtain a CERN Kerberos ticket:

You can obtain and cache a CERN Kerberos ticket (this is also required
for the way of using ssh-tunnel below) by:

    kinit YourNameAtCERN@CERN.CH

Please be aware that in the above command the realm **CERN.CH** must be
in **UPPERCASE**.

In addition, you can also use ssh-tunnel to **eosatlas.cern.ch**:

    ssh -NfL 1094:eosatlas:1094 lxplus.cern.ch

Then you can list files on EOS:

    xrd eosatlas.cern.ch dirlist /eos/atlas/..
    xrd localhost dirlist /eos/atlas/..   # if using ssh-tunnel

To copy files from EOS:

    xrdcp root://eosatlas.cern.ch//eos/atlas/YourDir/YourFilename.root .
    xrdcp root://localhost//eos/atlas/YourDir/YourFilename.root.root  .  # if using ssh-tunnel

Or you make use of the existing script **eos-copy.py**, which is an
alias and should have been defined for you upon login:

    % which eos-copy.py
    /afs/usatlas.bnl.gov/scripts/eos-copy.py

    % os-copy.py -h
    Usage: eos-copy.py [options] eos_source... local_dir
       eos-copy.py [options] eos_source... pnfs_dir

         widlcard such as "*.root" is allowed in the eos_source.

       This script uses xrdcp to copy files/dirs from CERN EOS to a local dir
    or a BNL pricate dCache dir. A valid CERN AFS token is required.


    Options:
      -h, --help  show this help message and exit
      --verbose   Print verbose info
      --version   Print the script version then exit

Or to read EOS files in ROOT:

    TFile *file = TFile::Open("root://eosatlas.cern.ch//eos/atlas/YourDir/YourFilename.root");
    TFile *file = TFile::Open("root://localhost//eos/atlas/YourDir/YourFilename.root");  # if using ssh-tunnel

### <span id="Access_to_CERN_EOS_in_BNL_batch"></span> Access to CERN EOS in BNL batch jobs

The method using ssh-tunnel would not work in batch jobs, you need
access them directly with root://eosatlas.cern.ch. However, for
protected EOS files, you need pass your CERN Kerberos ticket to the
batch machines in the following way:

1.  First define one envvar **KRB5CCNAME** prior to running
    `kinit YourNameAtCERN@CERN.CH`

        export KRB5CCNAME=$HOME/krb5cc_`id -u`

2.  Then add the envvar **KRB5CCNAME** to your condor batch jobs.

### <span id="Access_to_CERN_EOS_through_BNL_X"></span> Access to CERN EOS through BNL Xcache server

If you need repeat access the same EOS files, you can make use of the
BNL Xcache server to speed up the reading speed for the sequntial
access.

Just use the option **--eos=EOS\_PATH** in the script **Xcache\_ls.py**
to generate the clist files for your EOS files at CERN. Please run
**Xcache\_ls.py -h** for more details.

## <span id="Access_to_BNL_files_from_CERN_an"></span> Access to BNL files from CERN and outside BNL

You or your collaborators may need remote access to files at BNL.

### <span id="Access_to_BNL_dCache_files_from"></span> Access to BNL dCache files from CERN

You can use the following scripts
(**\~yesw/public/bnl/bnl\_pnfs-ls.py**) to generate clist or list files
under a given BNL /pnfs directory.

>     lxplus% ~yesw/public/bnl/bnl_pnfs-ls.py -h
>     Usage: 
>          bnl_pnfs-ls.py [-o clistFilename] [options] [pnfsFilePath | pnfsDirPath] [morePaths]
>
>       This script generates pfn (physical file name), pnfs-path,  
>     or xrootd-path of files on BNL dcache for given datasets or files on PNFS,
>     where wildcard is supported in pnfsFilePath and pnfsDirPath
>
>     Options:
>       -h, --help            show this help message and exit
>       -v                    Verbose
>       -V, --version         print my version
>       -l, --listOnly        list only matched datasets under users dCache, no pfn
>                             output
>       -o OUTPFNFILE, --outPfnFile=OUTPFNFILE
>                             write pfn list into a file instead of printing to the
>                             screen

For example, you run the above script in the following ways:

    lxplus% ~yesw/public/bnl/bnl_pnfs-ls.py -l /pnfs/usatlas.bnl.gov/users/yesw2000/testDir2
    lxplus% ~yesw/public/bnl/bnl_pnfs-ls.py -o my.clist /pnfs/usatlas.bnl.gov/users/yesw2000/testDir2
    1  files listed into clist file= my.clist

    You can use the generated clist file in your job in the following way:

        TChain* chain = new TChain(treeName);
        TFileCollection fc("fc","list of input root files","my.clist");
        chain->AddFileInfoList(fc.GetList());

### <span id="Access_to_BNL_other_file_systems"></span> Access to BNL other file systems from CERN

You can use **sshfs** to mount the remote BNL files to lxplus machines
locally. For example,

    lxplus% mkdir /tmp/yesw/data
    lxplus% sshfs spar0102:/atlasgpfs01/usatlas/data/yesw2000 /tmp/yesw/data

assuming that you have already set up the ssh configuration as shown in
[the section of interactive connection to BNL](../../sshlogin/ssh2BNL.md#Connect_to_the_interactive_nodes).

To umount the mounted point, just run **fusermount -u /tmp/yesw/data**.

To list all the sshfs mounted points, just run **pgrep -a -f sshfs**.

### <span id="Access_to_BNL_other_file_sys_AN1"></span> Access to BNL other file systems from other remote computers

For other computers outside of BNL such as your laptop, you can use the
say way as that for CERN. You can find the instruction of sshfs
installation on different OS at
[https://linuxize.com/post/how-to-use-sshfs-to-mount-remote-directories-over-ssh/](https://linuxize.com/post/how-to-use-sshfs-to-mount-remote-directories-over-ssh/).

