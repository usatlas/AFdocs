## Login into UChicago analysis facility

First you will need to sign up on the [Analysis Facility website](https://af.uchicago.edu/).
You can use your institutional or CERN identity (lxplus username) when signing up, the latter will make the approval process smoother. Please enter your full name, your home institution's name, and your institutional email; account requests from services like Gmail, Outlook, iCloud, etc. won't be accepted.  
In case you don't have an ATLAS membership yet, just send us an email explaining the reasons of your account request and add some US-ATLAS member connection. 

Once your account is accepted you need to generate an `SSH-key-pair` consisting of a `SSH-public-key` and a `SSH-private-key`; past the content of your SSH-public-Key on your profile and add your local machine identification to the site. Follow the instrucctions below:

Create your SSH-key-pair via the following command (Mac/Linux):

```sh
cd ~/.ssh
# the next command prompts you to enter a passphrase, specify a passphrase of your choice to protect your private key against unauthorized use.
ssh-keygen -t rsa -f idrsa_uc 
cd - # go back to previous directory
```

This generates 2 files: an SSH-private-key named **idrsa_uc**, and an SSH-public-key named **idrsa_uc.pub**, upload the resulting SSH-public-key to your profile on the Analysis Facility website by pasting its content on the "SSH public key" text box,
**`Important!: Do not copy the contents of a file that does not end in .pub. You must only upload the public (.pub) part of the key.`**

To print its content do:

```sh
cat ~/.ssh/idrsa_uc.pub
```

Now, add your identification from your local machine to the site:
First, open your `config` file, if the file doesn't exist just create it.  

```sh
# use the next line only if the file doesn't exist
touch config
# open the file and add the following lines, replacing <username> with your username:
Host uchicago
  HostName = login.af.uchicago.edu
  User = <username> 
  ForwardAgent yes
  IdentityFile ~/.ssh/idrsa_uc
# save and close the file
```

Finally, add your identification from your local machine using the following command:

```sh
# ssh-add  path-to-private-key 
ssh-add ~/.ssh/idrsa_uc
```

> `Tip`: If, while following the previous steps, you get this error message:  
> 
>     Could not open a connection to your authentication agent.
> You may need to start the `SSH-agent`, you can use this command:  
>    ```
>    eval "$(ssh-agent -s)"
>    ```   
 

Once you have uploaded the public key and added your local identification to the site it will take a little bit of time to process your profile and add your account to the system. After ~15 minutes, you should be able to login via SSH:
```
ssh -Y uchicago
```

If it does not work, please double check that you have been approved, have uploaded your public key and have waited at least 15 minutes. If you still have an issue, feel free to reach out to us for help.
