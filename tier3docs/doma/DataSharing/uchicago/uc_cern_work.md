## Access to CERN-EOS from UChicago

The ways to list, write and read files on CERN EOS, documented
[here](https://twiki.cern.ch/twiki/bin/view/AtlasComputing/ATLASStorageAtCERN#EOS_storage_system),
still work at UChicago.

!!! note

    `setup-eos` has been deprecated in favor of using `kinit`.

On the Analysis Facility login servers, try the following:

    kinit <cern_user>@CERN.CH

as described in [CERN Kerberos ticket](README.md#cern-kerberos-ticket). To list your
files located at /eos/user/d/dschrute/ :

    ls /eos/user/d/dschrute
    # remember to replace "d/dschrute" with your own username at CERN.

To create a new directory at /eos/user/d/dschrute/ :

    mkdir /eos/user/d/dschrute/new_dir
    # remember to replace "d/dschrute" with your own username at CERN.

To copy files from /eos/user/d/dschrute/ to your current directory:

    cp /eos/user/d/dschrute/file.txt .
    # use `cp -r` if you need to copy a directory

To copy files from /eos/user/d/dschrute/ to any path within your profile

    cp /eos/user/d/dschrute/file.txt  $HOME/codingx/ # eg: /home/dschrute/codingx/
    # use `cp -r` if you need to copy a directory
