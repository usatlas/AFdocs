
# <span id="Data_Storage"></span> Data Storage at BNL

# Table of Contents

  - [Storage Limits](#Limits)
  - [LOCALGROUPDISK](#LOCALGROUPDISK)
  - [Dataset Replication to LOCALGROUPDISK](#Dataset_replication_to_LOCALGROU)
  - [Use the BNL dCache Space](#Use_the_BNL_dCache_space)
    - [Access to the datasets on BNL dCache](#Access_to_the_datasets_on_BNL_dC)
    - [Download datasets to your pNFS area](#Download_datasets_to_your_pNFS_a)
    - [Access your data in your pNFS space](#Access_your_data_in_your_pNFS_sp)
  - [Use the BNLBox](#Use_the_BNLBox)
    - [Use the BNLBox on Web Browsers](#Use_the_BNLBox_on_Web_Browsers)
    - [Use the BNLBox on Linux machines](#Use_the_BNLBox_on_Linux_machines)
    - [Use the BNLBox on Mobile Devices](#Use_the_BNLBox_on_Mobile_Devices)


## <span id="Limits"></span> Storage Limits

|                |                                                                                                                                        |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------|
| Home area      | 20GB (with backup) per user under $HOME                                                                                                |
| Data area      | 500GB per user under /atlasgpfs01/usatlas/data/$USERNAME                                                                               |
| dCache area    | 5TB per user under /pnfs/usatlas.bnl.gov/users/$USERNAME.                                                                              |
| BNLBox         | 50GB (with backup) space under [https://bnlbox.sdcc.bnl.gov](https://bnlbox.sdcc.bnl.gov/), accessiblle from both mobile devices and computers       |
| LOCALGROUPDISK | 50TB (default) on the grid at BNL. Please check [below](#LOCALGROUPDISK) for more details                                              |

**Note**:

1.  In case the subdir **/pnfs/usatlas.bnl.gov/users/$USERNAME** does
    not exist, you can emaill to `"RT-RACF-StorageManagement@bnl.gov"`
    to help make the subdir.
2.  Additional space on BNLBox is available upon request.
3.  And there is also a 9TB **scratch disk** /usatlas/scratch/ shared among
    all users, where the files can be kept for **30 days**. Please make your
    own subdir **/usatlas/scratch/$USER** there.

### Guidance on storage usage

As a reminder, your home area ($HOME) is intended to store analysis
code, and not data.

Please use the other storage (**dCache**, **LOCALGROUPDISK**, and **Data area**)
to store data.

As for dCache, the files could be listed with the command `ls` under /pnfs.
However, they should be accessed via xrootd as explained 
[below](#Use_the_BNL_dCache_space).
And for batch jobs, it is recommended to write into the dCache at the job end.


## <span id="LOCALGROUPDISK"></span> LOCALGROUPDISK

If you need to store data outside of the resources dedicated to the BNL
Tier 3 (either due to needing more space, or to share data with
colleagues who are not using the BNL Tier 3), consider using
LOCALGROUPDISK, which is a resource that all US ATLAS collaborators have
access to. 
You can check at [RSE account usage](https://rucio-ui.cern.ch/r2d2/manage_quota) 
with the RSE **BNL-OSG2\_LOCALGROUPDISK** selected. Every user should
have a **default quota of 50TB**, if you could not find your name there,
please check if you have selected **/atlas/usatlas** in 
[the VO groups/roles](https://lcg-voms2.cern.ch:8443/voms/atlas/user/home.action).
For additional space if need beyond 50TB here is the [Request form]( https://atlas-lgdm.cern.ch/LocalDisk_Usage/USER/RequestFormUsage/)

### <span id="Dataset_replication_to_LOCALGROU"></span> Dataset Replication to LOCALGROUPDISK

You can replicate datasets to the RSE **BNL-OSG2\_LOCALGROUPDISK** in
the 2 following ways:

1.  Make the request through [r2d2 request](https://rucio-ui.cern.ch/r2d2/manage_quota)
2.  Make the request using rucio command **rucio add-rule**. Please
    check the [rucio add-rule wiki page](https://rucio.readthedocs.io/en/latest/man/rucio.html#add-rule)
    for usage help.

## <span id="Use_the_BNL_dCache_space"></span> Use the BNL dCache space

**[dCache](https://en.wikipedia.org/wiki/DCache)**
is a system for storing and retrieving huge amounts of data, distributed
among a large number of heterogeneous server nodes, under a single
virtual filesystem tree with a variety of standard access methods.

In order to use it efficiently, please do **NOT write output directly to
/pnfs** path (the dCache space), and also **avoid small files**. Instead
you should use the tool described below or Linux standard cp command. In
the following sub-sections, it describes the way to access and replicate
datasets to this system.

### <span id="Access_to_the_datasets_on_BNL_dC"></span> Access to the datasets on BNL dCache

In addition to Rucio (and DQ2Client), a convenient python script
**/afs/usatlas/scripts/pnfs\_ls.py** is provided to generate clist file
(list of physicsl file path) for files in given datasets on BNL dCache,
including datasets both on BNL rses 
(such as **[BNL-OSG2\_LOCALGROUPDISK](#LOCALGROUPDISK)**)
mentioned above) and under BNL users dCache area.

Please **click the following arrow** to see the full usage.

run **pnfs\_ls.py -h** to get the full usage

>     % pnfs_ls.py -h
>     Usage: 
>          pnfs_ls.py [options] dsetListFile
>       or
>          pnfs_ls.py [options] dsetNamePattern[,dsetNamePattern2[,more namePatterns]]
>       or
>          pnfs_ls.py -o clistFilename /pnfs/FilePathPattern [morePaths]
>       or
>          pnfs_ls.py -p -o clistFilename [pnfsFilePath | pnfsDirPath] [morePaths]
>
>       This script generates pfn (physical file name), pnfs-path,  
>     or xrootd-path of files on BNL dcache for given datasets or files on PNFS,
>     where wildcard and symlink are supported in pnfsFilePath and pnfsDirPath
>
>     Options:
>       -h, --help            show this help message and exit
>       -v                    Verbose
>       -V, --version         print my version
>       -p, --privateFiles    List private non-dataset files on dCache
>       -i, --incomplete      Use incomplete sites if complete not available
>       -u, --usersDCache     Use datasets under users private dCache
>       -l, --listOnly        list only matched datasets under users dCache, no pfn
>                             output
>       -o OUTPFNFILE, --outPfnFile=OUTPFNFILE
>                             write pfn list into a file instead of printing to the
>                             screen
>       -d OUTPFNDIR, --dirForPfn=OUTPFNDIR
>                             write pfn list into a directory with a file per
>                             dataset
>       -N, --usePNFS         using pNFS access, default is xrootd within BNL
>       --useXRootdOutside    using xroot from outside BNL: access, default is
>                             xrootd within BNL
>       -L LOCALBNLSITE, --localBNLSite=LOCALBNLSITE
>                             specify a BNL site, overriding the one choosen by the
>                             script

### <span id="Download_datasets_to_your_pNFS_a"></span> Download datasets to your pNFS area

This section describes how to download datasets from the grid to your
pNFS area (/pnfs/usatlas.bnl.gov/users/$USER/). If for some reason you
do not have a pNFS area you can fill out a ticket to this email group:
<RT-RACF-StorageManagement@bnl.gov>. If you have an pNFS area your name
should appear on this website:
[https://www.sdcc.bnl.gov/experiments/usatlas/list-users-institutes]
(https://www.sdcc.bnl.gov/experiments/usatlas/list-users-institutes).

**Note: You should not use rucio to download datasets!!!**

The command to download datasets is:

```
/afs/usatlas.bnl.gov/lsm/x8664_sl7/rucio/rucio-get-bnl.rb
```

Or create an alias of **<span
style="color: #ff0000">rucio-bnl-get</span>** to this script for ease of
use:

```
alias rucio-bnl-get=/afs/usatlas.bnl.gov/lsm/x8664_sl7/rucio/rucio-get-bnl.rb
```

To use this command, do the following on one of the Tier3 interactive
nodes.

**1. Set up the regular rucio environment:**

    setupATLAS
    lsetup rucio

**2. Make your proxy to be usatlas:**

    voms-proxy-init --old -valid 96:0 -voms atlas:/atlas/usatlas

Please be aware of the option **--old**. And it is important to use
**usatlas** role.

**3. Use the command.**

>     rucio-bnl-get --help
>     Usage: rucio-get-bnl.rb [options] DATASETNAME
>         -h, --help                       Display help message
>         -d, --db dbfile                  Specify sqlite3 file
>         -a, --rucio_account ruser        Specify rucio account name
>         -b, --base_dir baseDir           Specify base directory of your data
>         -t, --target target              Specify the destination host
>         -s, --retry                      Retry failed files
>         -r, --remove                     Remove the dataset
>         -c, --check                      Check local file

When you use the script to download a dataset it will download it to
/pnfs/usatlas.bnl.gov/users/$USER/rucio (the script will create the
rucio directory if it doesn't exist). The subdirectory structure will
include the rucio scope first.

**Example usage**  
Let's try to download this dataset, which only 5 files:

    rucio-bnl-get data11_7TeV:data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00
    ..
    FTSID=0f1fc3cc-da75-11e5-89dd-5cf3fc0c7c5c

**Notice**: If you got error like
`Could not find table 'rdatasets' (ActiveRecord::StatementInvalid)`, you
can delete the directory **$HOME/.rucio-get-bnl** and try again.

If you did not get any problem, then just wait a bit. You can repeat the
same command above to get the current FTS job status.

    rucio-bnl-get data11_7TeV:data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00
    Delegated Proxy Updated
    Last FTS status is FINISHED

So, in this case, it tells you it has already finished. But, it is also
possible to get "fail" or "finished dirty" if some transfers fail or are
active (ongoing) etc....

If one wants to check physically by looking at the file system, use
**--check** option.

    rucio-bnl-get data11_7TeV:data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00
    -c
    Delegated Proxy Updated
    Last FTS status is FINISHED
    x      
    /pnfs/usatlas.bnl.gov/users/hiroito/rucio/data11_7TeV/data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00/NTUP_TOP.366712._000001.root.1
    x      
    /pnfs/usatlas.bnl.gov/users/hiroito/rucio/data11_7TeV/data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00/NTUP_TOP.366712._000002.root.1
    x      
    /pnfs/usatlas.bnl.gov/users/hiroito/rucio/data11_7TeV/data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00/NTUP_TOP.366712._000003.root.1
    x      
    /pnfs/usatlas.bnl.gov/users/hiroito/rucio/data11_7TeV/data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00/NTUP_TOP.366712._000004.root.1
    x      
    /pnfs/usatlas.bnl.gov/users/hiroito/rucio/data11_7TeV/data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00/NTUP_TOP.366712._000005.root.1
    total # of files local / rucio :  5  /  5
    total size local  / rucio : 5829856628  /  5829856628

So, it really has 5 files locally in your T3 area. In this case, it is
my area ( /pnfs/usatlas.bnl.gov/users/$USER/rucio ) "x" indicates the
existence while "0" indicates missing.

In fact, I can do "ls -l" in T3 area (shown for $USER=hiroito).

    ls -l 
    /pnfs/usatlas.bnl.gov/users/hiroito/rucio/data11_7TeV/data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00/
    total 5693221
    -rw-rw-rw- 1 hiroito usatlas 1093230164 Feb 23 16:33
    NTUP_TOP.366712._000001.root.1
    -rw-rw-rw- 1 hiroito usatlas 1079699651 Feb 23 16:33
    NTUP_TOP.366712._000002.root.1
    -rw-rw-rw- 1 hiroito usatlas 1337274518 Feb 23 16:33
    NTUP_TOP.366712._000003.root.1
    -rw-rw-rw- 1 hiroito usatlas 1306566081 Feb 23 16:33
    NTUP_TOP.366712._000004.root.1
    -rw-rw-rw- 1 hiroito usatlas 1013086214 Feb 23 16:33
    NTUP_TOP.366712._000005.root.1

If you want to remove this file, use "--remove" option. That will remove
the local files as well as the entries in your own catalog.

eg,

    rucio-bnl-get data11_7TeV:data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00 --remove

After this,

    ls -l 
    /pnfs/usatlas.bnl.gov/users/hiroito/rucio/data11_7TeV/data11_7TeV.00182346.physics_Muons.merge.NTUP_TOP.f380_m855_p568_p570_tid366712_00/                                                                   

    total 0

Now, it is possible that the first attempt to transfer files fails with
some (or all) of files due to various reason. But, you can just retry it
with --retry option. This will only retry the failed transfers and will
use different source sites if available. This client has intentionally
does not do auto-retry to avoid complexity. But, it does not prevent you
to run it on the cron job for an example if you don't want to check it
manually. Also, you don't have to wait the completion of the first
dataset to submit the second one. You can submit as many as your space
is allowed.

**4. Getting statistics of your data.**

    /afs/usatlas.bnl.gov/lsm/x8664_sl6/rucio/rucio-bnl-usage.rb -h
    Usage rucio-bnl-usage.rb [options]
        -h, --help                       Display help message
        -d, --db dbfile                  Specify sqlite3 file

The above script
`/afs/usatlas.bnl.gov/lsm/x8664_sl6/rucio/rucio-bnl-usage.rb` has been
aliased as **<span style="color: #ff0000">rucio-bnl-usage</span>**.

eg.

>     rucio-bnl-usage
>     data12_8TeV:data12_8TeV.00201289.physics_Egamma.merge.NTUP_COMMON.r4644_p1517_p1562_tid01319778_00 size:694 (GB local)/ 694 (GB rucio)  number of files: 763 (local) / 763 (rucio) 
>     data11_7TeV:data11_7TeV.00183054.physics_Muons.merge.NTUP_TOP.f383_m872_p568_p570_tid414466_00 size:22 (GB local)/ 22 (GB rucio)  number of files: 20 (local) / 20 (rucio) 
>     mc15_13TeV:mc15_13TeV.361106.PowhegPythia8EvtGen_AZNLOCTEQ6L1_Zee.merge.DAOD_TOPQ4.e3601_s2576_s2132_r6630_r6264_p2413_tid06436984_00 size:159 (GB local)/ 159 (GB rucio)  number of files: 34 (local) / 34 (rucio) 
>     data10_7TeV:data10_7TeV.00167680.physics_MinBias.merge.AOD.r1774_p327_p333_tid206966_00 size:43 (GB local)/ 43 (GB rucio)  number of files: 10 (local) / 10 (rucio) 
>     data11_7TeV:data11_7TeV.00182455.physics_Muons.merge.NTUP_TOP.f381_m861_p568_p570_tid373751_00 size:1 (GB local)/ 1 (GB rucio)  number of files: 2 (local) / 2 (rucio) 
>     data11_7TeV:data11_7TeV.00182787.debugrec_hltacc.merge.NTUP_2LHSG2.g1_f382_m866_p527_tid377027_00 size:0 (GB local)/ 0 (GB rucio)  number of files: 0 (local) / 1 (rucio) 
>     data12_8TeV:data12_8TeV.00200863.physics_Egamma.merge.NTUP_PHOTON.r4065_p1278_p1341_p1343_p1345_tid01142890_00 size:0 (GB local)/ 0 (GB rucio)  number of files: 0 (local) / 1 (rucio) 
>     Total Local Usage: 923 (GB) with 829 files

If you have any questions, just open a new ticket at BNL RT
(<RT-RACF-USAtlasSharedT3@bnl.gov>).

### <span id="Access_your_data_in_your_pNFS_sp"></span> Access your data in your pNFS space

This section shows you how to access data in your pNFS space
(/pnfs/usatlas.bnl.gov/users/$USER/....)

BNL supports various interfaces to your area:

1\. **xrootd** (from interactive or any worker nodes)  
This might be the most optimum way within your interactive or
panda/condor jobs. All files are accessible via xrootd by prepending the
following

    root://dcgftp.usatlas.bnl.gov:1096/

For example:

    xrdcp -f root://dcgftp.usatlas.bnl.gov:1096//pnfs/usatlas.bnl.gov/users/hiroito/rucio/data10_7TeV/data10_7TeV.00167680.physics_MinBias.merge.AOD.r1774_p327_p333_tid206966_00/AOD.206966._000004.pool.root.1 /home/hiroito/abc.1
    [4.063GB/4.063GB][100%][==================================================][106.7MB/s]

Please notice that xrootd access would require a valid grid proxy, and
refer to [the batch system](#Use_the_batch_system)
on how to copy the grid proxy to batch machines.

2\. **NFS.4.1** (only from T3 machines - they are not available from BNL
production worker nodes.)  
Within T3 machines, files are accessible like normal NFS file. Just use
path.

3\. **Web** (from outside BNL)  
Using your browser, you can access your files via browser with your
valid certificate. just point to:  
[https://dcgftp.usatlas.bnl.gov:443/pnfs/usatlas.bnl.gov/users/youraccount/xyz/]
(https://dcgftp.usatlas.bnl.gov:443/pnfs/usatlas.bnl.gov/users/youraccount/xyz/).

## <span id="Use_the_BNLBox"></span> Use the BNLBox

BNL provides a cloud storage **BNLBox**, similar to the CERNBox, but
based on **NextCloud**. You can use it to share between computers and
mobile devices, among groups. Everyone has a **default quota of 50GB**.

You can find [more details on the SDCC page](https://www.sdcc.bnl.gov/information/services/using-bnlbox-cloud-storage)

It can be accessed from [web browsers](https://bnlbox.sdcc.bnl.gov),
[or desktop clients, or mobile apps]
(https://nextcloud.com/install/#install-clients).

### <span id="Use_the_BNLBox_on_Web_Browsers"></span> Use the BNLBox on Web Browsers

The web browser URL is
**[https://bnlbox.sdcc.bnl.gov](https://bnlbox.sdcc.bnl.gov)**.
You can log in with your BNL account. Please find out the webDAV access
URL by clicking on the bottom left **Settings** on the sidebar, as shown
below:

<img src="../BNLBox-webDAV.jpg" width="211" alt="BNLBox-webDAV.jpg" />

The webDAV URL is something like
`https://bnlbox.sdcc.bnl.gov/remote.php/dav/files/BNL-User-8efba3ed-bfc8-4324-9cef-e9f4878c3c8d/`,
where the last part in the path is your unique UUID.

### <span id="Use_the_BNLBox_on_Linux_machines"></span> Use the BNLBox on Linux machines

The software
**[cadaver](http://www.webdav.org/cadaver/)**
has been installed on spar/acas machines at BNL, and lxplus machines at
CERN. It is a command line webDAV client, with ftp-like commands. To
save you from typing the username/password everytime, you can prepare a
file **.netrc** under $HOME directory with the following content:

    machine bnlbox.sdcc.bnl.gov
      login yourLoginEmail
      password yourPassword

where you should put your own login and password. And run "chmod 600
$HOME/.netrc" to make this file visible only to yourself.

In addition, you can prepare another file **\~/.cadaverrc** with the
following line:

    open https://bnlbox.sdcc.bnl.gov/remote.php/dav/files/Your-LONG-UUID-for-BNLBox/

Please put your own long UUID here.

Then just simply run **"cadaver"**, it will connect to your BNLBox.

>     spar0101% cadaver
>     WARNING: Untrusted server certificate presented for `*.sdcc.bnl.gov':
>     Issued to: SDCC, Brookhaven National Laboratory, 53 Bell Avenue, Upton, New York, 11973-5000, US
>     Issued by: InCommon, Internet2, Ann Arbor, MI, US
>     Certificate is valid from Tue, 25 Sep 2018 00:00:00 GMT to Thu, 24 Sep 2020 23:59:59 GMT
>     Do you wish to accept the certificate? (y/n) y
>     dav:/remote.php/dav/files/BNL-User-8efba3ed-bfc8-4324-9cef-e9f4878c3c8d/> help
>     Available commands: 
>      ls         cd         pwd        put        get        mget       mput       
>      edit       less       mkcol      cat        delete     rmcol      copy       
>      move       lock       unlock     discover   steal      showlocks  version    
>      checkin    checkout   uncheckout history    label      propnames  chexec     
>      propget    propdel    propset    search     set        open       close      
>      echo       quit       unset      lcd        lls        lpwd       logout     
>      help       describe   about      
>     Aliases: rm=delete, mkdir=mkcol, mv=move, cp=copy, more=less, quit=exit=bye
>     dav:/remote.php/dav/files/BNL-User-8efba3ed-bfc8-4324-9cef-e9f4878c3c8d/>

You can use davix commands (**davix-ls**, **davix-put** and
**davix-get**) as well to access to your BNLBox. These commands are
available by default on lxplus. At BNL, you need run "setupATLAS -q;
lsetup davix" to set up the env. Then specify the full webDAV to the
davix commands plus an option **-k** (Disable SSL credential checks).

>     spar0101% setupATLAS -q
>     spar0101% lsetup davix
>     spar0101% davix-ls -k https://bnlbox.sdcc.bnl.gov/remote.php/dav/files/BNL-User-8efba3ed-bfc8-4324-9cef-e9f4878c3c8d/
>     davix: using ~/.netrc to load additional configuration. (match: bnlbox.sdcc.bnl.gov)
>     copy_bnl_box.rb
>     dCache
>     Documents
>     ._.DS_Store
>     .DS_Store
>     Nextcloud%20Manual.pdf
>     Nextcloud.mp4
>     Nextcloud.png
>     Photos
>     testDir
>     Archive

### <span id="Use_the_BNLBox_on_Mobile_Devices"></span> Use the BNLBox on Mobile Devices

For iOS or Android devices, just install the **Nextcloud** app, and
connect to **bnlbox.sdcc.bnl.gov**.

