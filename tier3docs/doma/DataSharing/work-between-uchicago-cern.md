## Work between UChicago and CERN

### <span id="Access_to_CERN_EOS_from_UChicago"></span> Access to CERN EOS from UChicago

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




