# Data Storage at UChicago

## Table of contents
+ [Storage Limits](#storage-limits)
+ [FileSystems](#filesystems)
<!--+ [-](#-)-->
## Storage Limits
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

The UChicago analysis facility has three filesystems with a clearly defined role. Please be aware of each of these roles when running workloads. 
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

