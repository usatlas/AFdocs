## Login into UChicago analysis facility

First you will need to sign up on the [Analysis Facility
website](https://af.uchicago.edu/). You can use your institutional or CERN
identity (lxplus username) when signing up, the latter will make the approval
process smoother. Please enter your full name, your home institution's name,
and your institutional email; account requests from services like Gmail,
Outlook, iCloud, etc. won't be accepted.  In case you don't have an ATLAS
membership yet, just send an email to **atlas-us-chicago-tier3-admins@cern.ch**
explaining who you are working with in ATLAS, and why you need an account.

Once your account is accepted, you will need to generate a cryptographic SSH
key consisting of a public key, which you will upload to your profile on the AF
portal, and a private key which you will keep on your laptop.

On Mac/Linux, you can create an SSH key pair using the following command and
follow the prompts:

```sh
ssh-keygen -t ed25519
```

We recommend setting a passphrase on your private key. This way, if your
private key is ever lost or compromised, an attacker would still need your
passphrase in order to impersonate you.

We also recommend modern elliptic curve key types, such as `ed25519` or
`ecdsa`. The UChicago Analysis Facility will *not* accept deprecated key types
such as DSA or RSA with a SHA-1 signature, as these are generally considered
insecure.

The `ssh-keygen` command will generate two files in `~/.ssh` (unless you chose
a different location). If you used the `ed25519` key type recommend above with
the default location, your private key should be located at `~/.ssh/id_ed25519`
with its corresponding public key located at `~/.ssh/id_ed25519.pub`.

Once you have generated your key pair, you should upload the resulting public
key (e.g., `id_ed25519.pub`) to your profile on the Analysis Facility portal
by pasting its content into the "SSH public key" text box.

**Important: You must only upload the public key (.pub)! Treat the private key
as if it were your password.**

Assuming you created an ed25519 key per instructions above, you can view the
public key with the following command:

```sh
cat ~/.ssh/id_ed25519.pub
```

Once you have uploaded your public key to your profile, it will take a little
while to synchronize with the rest of the system account to the system. After
~15 minutes, you should be able to login via SSH:
```
ssh login.af.uchicago.edu
```

If it does not work, please double check that you have been approved, have
uploaded your public key and have waited at least 15 minutes. If you still have
an issue, feel free to reach out to us for help either via
[Discourse](https://atlas-talk.sdcc.bnl.gov/) or email
**atlas-us-chicago-tier3-admins@cern.ch**

### (optional) Create an SSH config file and add your key to the agent 

Now, add your identification from your local machine to the site:
First, open or create the `~/.ssh/config` file.

```sh
# Create the configuration file if it does not yet exist
touch ~/.ssh/config
# open the file and add the following lines, replacing <username> with your username:
Host uchicago
  HostName = login.af.uchicago.edu
  User = <username> 
  ForwardAgent yes
  IdentityFile ~/.ssh/id25519
# save and close the file
```

Finally, add your identification from your local machine using the following command:

```sh
# ssh-add path-to-private-key 
ssh-add ~/.ssh/id25519
```

> `Tip`: If, while following the previous steps, you get this error message:  
> 
>     Could not open a connection to your authentication agent.
> You may need to start the `SSH Agent`, you can use this command:  
>    ```
>    eval "$(ssh-agent -s)"
>    ```   
