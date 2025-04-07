# FAQs and Tips for Tier3 users

### No valid kerberos after lxplus login.
   If you have already had a valid CERN kerberos token on the local computer
   from which you ssh to lxplus machines, you might see the following 
   error message after ssh login to CERN lxplus machines.

```
/usr/bin/xauth:  timeout in locking authority file /afs/cern.ch/user/y/yesw/.Xauthority
```

   And it is very annoying that you have to run "kinit" again after ssh login.

   To avoid the above trouble, you can:

   - either add the option **"-k"** to the ssh command.
   - or add **"GSSAPIDelegateCredentials yes"** into ~/.ssh/config on 
     the local computer.

### Sharing the same kerberos token among the home clusters

   By default, the kerberos token is cached locally on each individual machine, and you have to run kinit each time on a different node.
   If those machines share the same home directory, you can define the envvar **KRB5CCNAME** to **$HOME/krb5cc_`id -u`** prior to running **kinit**.
   So you would have a valid kerberos token on other machines too.
    
   For example, once you have obtained a valid CERN kerberos on one BNL attsub machine, 
   you can also access CERN EOS on other attsub machines without running "kinit" again.
    
### Sharing one envvar KRB5CCNAME among multiple kerberos principals
   The envvar **KRB5CCNAME** points to a file, it could only hold one kerberos prinpical. 

   However, you can define it to point to a directory instead, then it could be used for multiple kerberos pricipals.
   That is:
```
  export KRB5CCNAME=DIR:$HOME/.krb5cc
```
   Please note the prefix **"DIR:"** before the directory name. And you need create the directory **$HOME/.krb5cc** in advance.

### How to set up python3 env from CVMFS?
   Run **showVersions python** after the ALRB setup (that is, running *setupATLAS*).
   It will show the available python versions on CVMFS.
   
   Then you can pick up one suitable for you, says, *3.8.8-x86_64-centos7*.
   So you can run **lsetup "python 3.8.8-x86_64-centos7"** to set up that python3.

### How to set up Rucio with python3?
  On default, rucio uses python2. So how to set up the rucio env to use in python3?
  
  You can run the following:
```
  export RUCIO_PYTHONBIN=python3
  lsetup rucio
```

### How to transfer QR code from Google Authenticator to other devices?
  There are many services requiring **MFA** (Multi-Factor Authentication). It would be more convenient to have multiple devices for MFA.
  To run the MFA app and the service requiring MFA on the same computer, you can just copy and paste the passcode into the service (such as BNL NX login),
  without checking your phone to get the passcode and input the passcode into the service.
  
  If you set up the MFA originally with Google Authenticator on your phone, 
  and want to add other devices (including computers) into the MFA list (for convenience and backups), 
  you need extract the secret code from Google Authenticator, then add the secret code into other devices in the following:
  
1. Export the QR codes from "Google Authenticator" app

2. Read QR codes with QR code reader

3. Save the captured QR codes in a text file. Save each QR code on a new line. (The captured QR codes look like otpauth-migration://offline?data=...)

4. Call [this script on github](https://github.com/scito/extract_otp_secret_keys):
```
python extract_otp_secret_keys.py -p example_export.txt
```

### Problem in the Duo Mobile app
  If you get the following error message with **Duo Mobile** app:
```
Authentication Restricted
Your administrator requires your phone to have a passcode
```
which may indicate that the screen lock is not enabled on your phone. You can find the details [here](https://help.duo.com/s/article/3159?language=en_US).

So you can simply enable the screen lock on your phone to resolve the above problem.

