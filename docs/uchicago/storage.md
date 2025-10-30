# Data Storage at UChicago

## Storage Limits

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
<td> 5 TB </td>
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

## Filesystems

The UChicago analysis facility has three filesystems with a clearly defined
role. Please be aware of each of these roles when running workloads.

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

## Which Filesystem to Use

Your account on the UChicago Analysis Facility will be allocated space on the
`$HOME` and `$DATA` filesystems when your account is approved. By default, we
give each user 100GB of storage on the `$HOME` filesystem (i.e.,
`/home/<username>`). This filesystem is backed up weekly and is more optimized
for small files such as job logs, submit files, code and so on.

Data files, on the other hand, should be placed in the `$DATA` filesystem
(`/data/<username>`) which is more suitable for large files but is **not**
backed up. By default, you will be given a 5TB quota on this filesystem. If you
are working on an analysis that requires more local storage, please
[contact the UChicago facility team](../getting_help.md#facility-specific-support)
and we'll do our best to accommodate your request.

Finally, jobs submitted to HTCondor will be assigned to a server with one or
more dedicated high-speed "scratch" disks to use as working space when
processing your jobs, each with a few TB of available space. This is important
for two reasons:

- The scratch disk is _local_. We strongly recommend that you copy your input
  data from `$DATA` to `$SCRATCH` when running a job because this will generally
  deliver the best performance.
- The scratch disk is _ephemeral_. HTCondor will automatically clean up the
  scratch disk for the next workload when your job has finished using it.

/// warning | Don't lose your data!

With this in mind, you will need to make sure that you copy your output data
away from the `$SCRATCH` filesystem and into the `$DATA` filesystem at the end
of your job. Any data left in `$SCRATCH` will be lost at the end of your job!
When submitting jobs, you should try to use the scratch disk whenever possible.
This will help you be a "good neighbor" to other users on the system, and reduce
overall stress on the shared filesystems, which can lead to slowness, downtimes,
etc.

///

To summarize, please review the following table:

| Filesystem | Best for ...                  | Backup | Access from ...    | Default Quota |
| ---------- | ----------------------------- | ------ | ------------------ | ------------- |
| $HOME      | Code, Logs, Submit files      | Weekly | SSH, Jupyter, Jobs | 100GB         |
| $DATA      | ROOT files, other large files | None   | SSH, Jupyter, Jobs | 5TB           |
| $SCRATCH   | Transient job files           | None   | Jobs only          | No quota      |

## LOCALGROUPDISK

If you need more space to storage data, need to share it with your teamwork or
colleagues who are not necessarily using the UChicago Analysis Facility you can
use LOCALGROUPDISK which is a disk resource for all US-ATLAS members. Check the
Rucio documentation at
[RSE Rucio manage quota](https://rucio-ui.cern.ch/r2d2/manage_quota), type
`MWT2_UC_LOCALGROUPDISK` in the text box:

![rse rucio manage quota](uc_rucio_localgroupdisk.png)

and click the `select` button. If you search your lxplus username you'll see
that you have a default quota of 15TB. For additional space if need beyond 15TB
here is the
[Request form](https://atlas-lgdm.cern.ch/LocalDisk_Usage/USER/RequestFormUsage/).
Remember that you need US-ATLAS VO for the grid certificate.

If you are an ATLAS member but can't find your name go to
[VOMS page](https://lcg-voms2.cern.ch:8443/voms/atlas/user/home.action) and
select /atlas/usatlas in the "groups roles" box:

![voms groups roles](uc_vo_roles.png)

### Transfer datasets to LOCALGROUPDISK

To transfer datasets to LOCALGROUPDISK, check the following 3 options:

- Using **r2d2**, make your request in the Rucio page
  [rucio r2d2 request](https://rucio-ui.cern.ch/r2d2/request):
  ![rucio r2d2 request](uc_r2d2_request.png)
- Adding “-destSE” to your PANDA job.
- Via Rucio on the command line

### How to access datasets

To access datasets, you can choose one of the following 3 options.

- In grid-based analyses
- Through XRootD from shared T3’s, check the
  [Data Sharing section](http://127.0.0.1:8000/doma/DataSharing/).
- Download locally, remember to use the proper filesystem, eg: to storage large
  data samples files use $data.
