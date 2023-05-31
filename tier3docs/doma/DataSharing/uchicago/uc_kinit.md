## CERN Kerberos ticket 

You can obtain and cache a CERN Kerberos ticket (this is also required for the way of using ssh-tunnel below) by doing:
`Please notice that the domain CERN.CH must be in UPPERCASE.`

```bash
kinit <name_at_CERN>@CERN.CH
``` 
List your ticket: 

```bash
klist
```

### Pass your CERN Kerberos ticket to your HTCondor jobs

Before running the previous command `kinit <name_at_CERN>@CERN.CH` pass your CERN Kerberos ticket to the batch machines:
```bash
export KRB5CCNAME=$HOME/krb5cc_`id -u` # this defines the environment variable `KRB5CCNAME`$
```

Then add the environment variable KRB5CCNAME to your condor batch job,eg:

```bash
...
environment = <parameter_list>
...
x509userproxy  = $ENV(X509_USER_PROXY) # this adds KRB5CCNAME to your condor batch job.
```


