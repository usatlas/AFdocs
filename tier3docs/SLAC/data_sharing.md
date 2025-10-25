# Data Sharing at SLAC

This guide covers data sharing methods available at SLAC, including Xcache
servers and the Data Sharing Store.

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

---

## Data Sharing Store at SLAC

US ATLAS is experimenting a data sharing store service at SLAC AF. The goal is
to enable easy data sharing with your ATLAS colleagues.

### Features

This is an object store with the following features:

1. Allows ATLAS users to upload/delete files using `root` or `https` protocols.
   Anyone can download a file (see Privacy section). This service is not limited
   to US ATLAS.
2. Files uploaded there have a lifetime of N-days. After that period, they will
   be purged without notice. Currently N is set to 60 at SLAC AF.
3. The top level directory in the object store is not browsable.

The object store is available at the following URLs:

- `https://sdf-dtn10.slack.stanford.edu:2094/share`
- `root://sdf-dtn10.slack.stanford.edu:2094//share` (double slash after :2094)

### Privacy

!!! warning "Low sensitivity data only"

    Browsing/Listing of `/share` is disabled in order to provide a level of privacy that is suitable for sharing **low sensitivity data**.

For example, if one copies a data file to:

`https://sdf-dtn10.slack.stanford.edu:2094/share/random-string/myfile.dat`

Others would not know the existence of `myfile.dat` unless they were told about
the `random-string`. This is because `/share` is not searchable. As the owner,
you should write down the random string and keep it secure. Anyone who know the
random string can search for the content under it.

!!! danger "Important: Keep your random string secure"

    If you lose the random string, you lose access to your data. Administrators won't be able to help you since there is no records of ownership in the object store. The data will eventually be purged after expiration.

### Upload and Download

You will need an X509 proxy with ATLAS VOMS attribute to upload and delete. No
such requirement for downloading, though some tools will insist to have a X509
proxy before proceeding. So run command `voms-proxy-init -voms atlas` first to
obtain an X509 proxy with ATLAS VOMS attribute.

Then if you will upload, think of a hard-to-guess random string to be used after
`/share`. One secure way to generate a random string is to use Unix command
`uuidgen`, and write it down!

There are three set of tools that can be used to upload/download/delete a file.
In addition, you can also use your web browser to download.

#### Using curl to upload/download/delete

curl is available everywhere. To use curl, follow these steps:

1.  Create an alias to type less:

    ```bash
    alias mycurl="curl -E /tmp/x509up_u$(id -u) --cacert /tmp/x509up_u$(id -u) --capath /etc/grid-security/certificates"
    ```

    !!! note

        You may need to adjust the proxy location and CA directory location (/etc/grid-security/certificates) in your environment.

2.  Upload:

    ```bash
    mycurl -L -X PUT --upload-file /tmp/mydata.file https://sdf-dtn10.slack.stanford.edu:2094/share/random-string/myfile.dat
    ```

3.  Download:

    ```bash
    mycurl -L -X GET https://sdf-dtn10.slack.stanford.edu:2094/share/random-string/myfile.dat
    ```

4.  Delete:

    ```bash
    mycurl -L -X DELETE https://sdf-dtn10.slack.stanford.edu:2094/share/random-string/myfile.dat
    ```

#### Use gfal2 tools to upload/download/delete

You may need to setup the ATLAS environment (run `localSetupRucioClients`) to
have the gfal2 tools in your PATH.

1. Upload:

   ```bash
   gfal-copy -f /tmp/myfile.dat https://sdf-dtn10.slack.stanford.edu:2094/share/random-string/myfile.dat
   ```

2. Download:

   ```bash
   gfal-copy -f https://sdf-dtn10.slack.stanford.edu:2094/share/random-string/myfile.dat /tmp/myfile.dat
   ```

3. Delete:

   ```bash
   gfal-rm https://sdf-dtn10.slack.stanford.edu:2094/share/random-string/myfile.dat
   ```

4. You can even do:

   ```bash
   gfal-copy -f https://cern.ch//SCRATCHDISK/myfile.dat https://sdf-dtn10.slack.stanford.edu:2094/share/random-string/myfile.dat
   ```

!!! tip

    Gfal2 tools work with both https and root protocols. In the last example, the source and destination can use different protocols.

#### Use xrootd tools to upload/download/delete

You may need to setup the ATLAS environment (run `localSetupRucioClients`) to
have the xrootd tools in your PATH. These tools will mostly work with the root
protocol. Note that in a root URL, there is usually a double slash after the
port number.

1. Upload:

   ```bash
   xrdcp -f /tmp/myfile.dat root://sdf-dtn10.slack.stanford.edu:2094//share/random-string/myfile.dat
   ```

2. Download:

   ```bash
   xrdcp -f root://sdf-dtn10.slack.stanford.edu:2094//share/random-string/myfile.dat /tmp/myfile.dat
   ```

3. Delete:

   ```bash
   xrdfs root://sdf-dtn10.slack.stanford.edu:2094 rm /share/random-string/myfile.dat /tmp/myfile.dat
   ```

4. You can also do:

   ```bash
   xrdcp -f root://cern.ch//SCRATCHDISK/myfile.dat root://sdf-dtn10.slack.stanford.edu:2094//share/random-string/myfile.dat /tmp/myfile.dat
   ```

!!! note

    With additional setting, xrdcp also works with the https protocol.

#### Use a web browser

You can use a web browser to download file and list a directory (except the top
level, which is not browsable). To do that, just paste the https URL to your
browser.

It is not possible to use a web browser for upload and deletion.
