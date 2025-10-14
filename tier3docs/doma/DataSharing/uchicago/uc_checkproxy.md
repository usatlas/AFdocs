## Always check your proxy certificate

If you are trying to use HTCondor driver to run some jobs that need data access
authorization, for example on `rucio`. In any of the ways described to access
your data always check the status of your proxy grid certificate. Your x509proxy
certificate has expiry date, once it expires you have to create an ATLAS VOMS
proxy again in the usual way. As you know you create (or copy it to) on the
shared $HOME filesystem so that the HTCondor scheduler can find and read the
proxy. This is how you copy it to $HOME:

```
voms-proxy-init -voms atlas -out $HOME/x509proxy
```

**notice that** without the term `-out $HOME/x509proxy` you create a new proxy
but the one that maybe is already in your $HOME directory is still expired. Once
you renew you proxy certificate, add _line1_ and _line2_ from the following
example to your job submit file so that HTCondor configures the job environment
automaticcaly for x509 authenticated data access.

```bash
universe = vanilla

use_x509userproxy = true  #line1
x509userproxy = /home/dschrute/x509proxy #line2

request_memory = 1GB
request_cpus = 1
queue 1
```
