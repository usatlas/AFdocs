## Login into UChicago analysis facility

First you will need to sign up on the [Analysis Facility website](https://af.uchicago.edu/).
You can use your institutional or CERN identity (lxplus username) when signing up, this last will make the approval process smoother. Please enter your fullname and your institutional(CERN) email, accounts requests from services like Gmail, Outlook, iCloud, etc. won't be accepted.  
In case you don't have an ATLAS membership yet, just send us an email explaining the reasons of your account request and add some US-ATLAS member connection. 

Once your account is accepted you will need to upload an SSH Public Key.
If you are not sure if you have generated an SSH Public Key before, try the following command (Mac/Linux) on your laptop to print the content of the file that contains the SSH Public Key:

```
cat ~/.ssh/id_rsa.pub
```

If the file exists, you should be able to copy the contents of this file to your profile on the AF website. **`Important!: Do not copy the contents of a file that does not end in .pub. You must only upload the public (.pub) part of the key.`**



If you do not have a public key (the file doesn't exist), you can generate one via the following command (Mac/Linux):

```
ssh-keygen -t rsa
```

Upload the resulting public key (ending in .pub) to your profile.

Once you have uploaded a key, it will take a little bit of time to process your profile and add your account to the system. After 10-15 minutes, you ought to be able to login via SSH:
```
ssh <username>@login.af.uchicago.edu
```
If it does not work, please double check that you have been approved, have a public key uploaded and have waited at least 15 minutes. If you still have an issue, feel free to reach out to us for help.

### UChicago analysis facility filesystems 
**Or: Where to start working**

The UChicago analysis facility has three filesystems that you should be aware of when running workloads. Each filesystem each has a clearly defined role:
[]:#(table with filesystems functions)
<table>
<thead>
<tr>
<th>Filesystem</th>
<th>Function</th>
</tr>
</thead>
<tbody>
<tr>
<td>$home</td>
<td><p>Your home area is intended to store small files like analysis code, scripts, small samples.
<br>Please store your big data files on the $data filesystem. </td></p>
</tr>
<tr>
<td>$data</td>
<td><p>This directory is the dedicated shared filesystem to storage data, i.e. the big files, <br>that is, for example your data samples.</td></p>
</tr>
<tr>
<td>$scratch</td>
<td>
<p>This filesystem is an ephemeral storage for workloads and local to worker nodes.
<br> All jobs start in this directory on the worker nodes by default. 
<br>Consequently, Output data will need to be staged to the shared filesystem or it will be lost!.
<br> In the next sections you can find examples and more details about this directory and its use.
</p>
</tbody>
</table>
This table describes more of their diferences
[]:#(table2  with filesystems differences)

<table>
<thead>
<tr>
<th>Filesystem</th>
<th>Quota</th>
<th>Path</th>
<th>Backed up?</th>
<th>Notes</th>
</tr>
</thead>
<tbody>
<tr>
<td>$home</td>
<td>100GB</td>
<td>/home/$user </td>
<td>Yes</td>
<td>Solid-state filesystem, shared to all worker nodes</td>
</tr>
<tr>
<td>$data</td>
<td> 10 TB </td>
<td>/data/$user  </td>
<td>No</td>
<td>CephFS filesystem, shared to all worker nodes</td>
</tr>
<tr>
<td>$scratch</td>
<td>n/a  </td>
<td>/scratch</td>
<td>No </td>
<td>Ephemeral storage for workloads, local to worker nodes</td>
<td>
</tr>
</tbody>
</table>
