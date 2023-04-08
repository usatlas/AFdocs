## Login into UChicago analysis facility

First you will need to sign up on the [Analysis Facility website](https://af.uchicago.edu/).
You can use your institutional or CERN identity (lxplus username) when signing up, this last will make the approval process smoother. Please enter your fullname, your home institution name, and your institutional email, accounts requests from services like Gmail, Outlook, iCloud, etc. won't be accepted.  
In case you don't have an ATLAS membership yet, just send us an email explaining the reasons of your account request and add some US-ATLAS member connection. 

Once your account is accepted you will need to upload an SSH Public Key.
If you are not sure if you have generated an SSH Public Key before, try the following command (Mac/Linux) on your laptop to print the content of the file that contains the SSH Public Key:

```
cat ~/.ssh/id_rsa.pub
```

If the file exists, you should be able to copy the contents of this file to your profile on the AF website. **`Important!: Do not copy the contents of a file that does not end in .pub. You must only upload the public (.pub) part of the key.`**


If you do not have a public key (the file doesn't exist), you can generate one via the following command (Mac/Linux):

```
cd ~/.ssh
ssh-keygen -t rsa -f idrsa_uc
cd - # go back to previous directory
```

This will create 2 files: a private key named **idrsa_uc**, and a public key named **idrsa_uc.pub**, upload the resulting public key to your profile on the "SSH public key" box (in case you haven't done it already), to print its content use:

```
cat ~/.ssh/idrsa_uc.pub
```
and also add your identification from your local machine to the site:

```
# ssh-add path-to-private-key
ssh-add ~/.ssh/idrsa_uc
```

Once you have uploaded the public key and added your identification to the site it will take a little bit of time to process your profile and add your account to the system. After 10-15 minutes, you ought to be able to login via SSH:
```
ssh <username>@login.af.uchicago.edu
```
If it does not work, please double check that you have been approved, have a public key uploaded and have waited at least 15 minutes. If you still have an issue, feel free to reach out to us for help.

