# FAQs/Tips for Tier3

### No valid kerebos after lxplus login.
   If you have already had a valid CERN kerberos token on the local computer
   from which you ssh to lxplus machines, you might see the following 
   error message after ssh login to CERN lxplus machines.

'''
/usr/bin/xauth:  timeout in locking authority file /afs/cern.ch/user/y/yesw/.Xauthority
'''

   And it is very annoying that you have to run "kinit" again after ssh login.

   To avoid the above trouble, you can:

   - either add the option **"-k"** to the ssh command.
   - or add **"GSSAPIDelegateCredentials yes"** into ~/.ssh/config on 
     the local computer.

### How to set up python3 env from CVMFS?
   Run **showVersions python** after the ALRB setup (that is, running *setupATLAS*).
   It will show the available python versions on CVMFS.
   Then you can pick up one suitable for you. Says, *3.8.8-x86_64-centos7*,
   so you can run **lsetup "python 3.8.8-x86_64-centos7"** to set up that python3.

### Using python3 in Rucio setup
  export RUCIO_PYTHONBIN=python3
  lsetup rucio

### Transfer QR code from Google Authenticator to other devices
  to other devices (such as computer/laptop)

### ScreenLock required for Duo Push


