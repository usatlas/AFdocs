## <span id="Use_the_Xcache_servers"></span> Use the Xcache servers

Both BNL and SLAC have set up the **Xcache servers**, to help cache
locally the file on the grid or **CERN EOS**. Currently there are 60TB
on the BNL Xcache server, and 20TB on the SLAC Xcache server.

The Xcache servers

-   provide **rucioN2N feature**, enabling users to access any files on
    the grid without knowing its exact site location and the file path.
-   and help **cache locally** the content of remote files actually read
    in the first access, thus improves the read performance for
    sequential access. If only partial content of a file is read, then
    only that part would cached.

You can run the predefined command **Xcache\_ls.py** to generate a clist
file (containing a list of physicsl file paths) for given datasets, then
use the clist in your jobs.

Please **click the following arrow** to see the full usage of
Xcache\_ls.py.

run **Xcache\_ls.py -h** to get the full usage

>     % Xcache_ls.py -h
>     Usage: 
>          Xcache_ls.py [options] dsetNamePattern[,dsetNamePattern2[,more patterns]]
>       or
>          Xcache_ls.py [optiones] --eos eosPath/
>       or
>          Xcache_ls.py [optiones] --eos eosPath/filenamePattern
>       or
>          Xcache_ls.py [options] dsetListFile
>
>       This script generates a list (clist) of 
>       Xcache gLFN (global logical filename) access path 
>       for given datasets on Atlas grid sites.
>       Wildcard is supported in the dataset name pattern.
>
>     Options:
>       -h, --help            show this help message and exit
>       -v                    Verbose
>       -V, --version         print my version
>       -X XCACHESITE, --XcacheSite=XCACHESITE
>                             Specify a Xcache server site of BNL or SLAC
>                             (default=BNL)
>       -o OUTCLISTFILE, --outClistFile=OUTCLISTFILE
>                             write the list into a file instead of the screen
>       --eos=EOS_PATH, --cerneos=EOS_PATH
>                             List files (*.root and *.root.[0-9] on default) on
>                             CERN EOS
>       -d OUTCLISTDIR, --dirForClist=OUTCLISTDIR
>                             write the list into a directory with a file per
>                             dataset

However, for large file inputs on the grid, you are recommended to plan
ahead and pre-stage them to BNL using [R2D2
request](https://rucio-ui.cern.ch/r2d2/manage_quota)
or rucio command.
