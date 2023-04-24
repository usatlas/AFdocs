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
    
To create a new directory at /eos/user/d/dschrute/ :
    
    eos root://eosuser.cern.ch mkdir /eos/user/d/dschrute/new_dir 
    # remember to replace "d/dschrute" with your own username at CERN.
    
To copy files from /eos/user/d/dschrute/ to your current directory: 

    xrdcp root://eosuser.cern.ch//eos/user/d/dschrute/file.txt .
    # use `xrdcp -r` if you need to copy a directory
    
To copy files from /eos/user/d/dschrute/ to any path within your profile

    xrdcp root://eosuser.cern.ch//eos/user/d/dschrute/file.txt  /any-path/ # /any-path/ eg: /home/dschrute/codingx/
    # use `xrdcp -r` if you need to copy a directory
#### Keep in mind your proxy certificate
If you are trying to use HTCondor driver to run some jobs that need data access authorization, for example on `rucio`, always check the status of your proxy grid certificate.
Your x509proxy certificate has expiry date, once it expires you have to create an ATLAS VOMS proxy again in the usual way. As you know you create (or copy it to) on the shared $HOME filesystem so that the HTCondor scheduler can find and read the proxy. This is how you copy it to $HOME:

```
voms-proxy-init -voms atlas -out $HOME/x509proxy 
```	
**notice that** withouth the term `-out $HOME/x509proxy` you create a new proxy but the one that maybe is already in your $HOME directory is still expired.
Once you renew you proxy certificate, add *line1* and *line2* from the following example to your job submit file so that HTCondor configures the job environment automaticcaly for x509 authenticated data access.

```bash
universe = vanilla

use_x509userproxy = true  #line1
x509userproxy = /home/dschrute/x509proxy #line2
	
request_memory = 1GB
request_cpus = 1
queue 1
```

    




