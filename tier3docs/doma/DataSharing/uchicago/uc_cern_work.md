<font size="6">**Table of contents**</font>
  <br> - [Access to CERN-EOS from UChicago](#uc_access_cerneos)
  <br> - [Xcache at UChicago](#uc_xcache)
  <br> - [Always check your proxy certificate](#uc_checkproxy)

# <span id="uc_access_cerneos"></span> Access to CERN-EOS from UChicago

The ways to list, write and read files on CERN EOS, documented
[here](https://twiki.cern.ch/twiki/bin/view/AtlasComputing/ATLASStorageAtCERN#EOS_storage_system),
still work at UChicago.

On the Analysis Facility login servers, try the following:

    export LXPLUS_USER=<your lxplus username>
    setup-eos start

this makes a directory called $HOME/your_uchicago_username/eos and mount EOS there.

To list your files located at /eos/user/d/dschrute/ :

    eos root://eosuser.cern.ch ls /eos/user/d/dschrute 
    # remember to replace "d/dschrute" with your own username at CERN.
    
To create a new directory at /eos/user/d/dschrute/ :
    
    eos root://eosuser.cern.ch mkdir /eos/user/d/dschrute/new_dir 
    # remember to replace "d/dschrute" with your own username at CERN.
    
To copy files from /eos/user/d/dschrute/ to your current directory: 

    xrdcp root://eosuser.cern.ch//eos/user/d/dschrute/file.txt .
    # use `xrdcp -r` if you need to copy a directory
    
To copy files from /eos/user/d/dschrute/ to any path within your profile

    xrdcp root://eosuser.cern.ch//eos/user/d/dschrute/file.txt  /any-path/ # /any-path/ eg: /home/dschrute/codingx/
    # use `xrdcp -r` if you need to copy a directory
