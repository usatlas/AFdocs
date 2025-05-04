## HTCondor user's guide
### Use condor within eventloop
If you are using EventLoop to submit your code to the Condor batch system you should replace your submission driver line with something like the following:

```bash
EL::CondorDriver driver;
job.options()->setString(EL::Job::optCondorConf, "getenv = true\naccounting_group = group_atlas.<institute>");
driver.submitOnly( job, "yourJobName”);
```
<h3> Useful attributes for the jobs submission file</h3>

<div class="wy-table-responsive"><table class="docutils">
<thead>
<tr>
<th>Option</th>
<th>What is it for?</th>
</tr>
</thead>
<tbody>
<tr>
<td>transfer_output_files=</td>
<td>When it isn't specified, it automatically transfers back all files that have been created or modified in the job’s temporary working directory.</td>
</tr>

<tr>
<td>transfer_input_files</td>
<td>HTCondor transfer input files from the machine where the job is submitter to the machine chosen to execute the job</td>
</tr>

<tr>
<td>when_to_transfer_output</td>
<td><ul><li>on_exit:(default) when the job ends on its own</li><li>on_exit_or_evict: fit the job is evicted from the machine</li></ul></td>
</tr>

<tr>
<td>should_transfer_files</td>
<td><ul><li>yes: always transfer files to the remote working directory</li><li>if_needed: (default) access the files from a shared file system if possible, otherwise it will transfer the file</li><li> no: disables file transfer </li><li>command specifies whether HTCondor should assume the existence of a file system shared by the submit machine and the execute machine.</li></ul></td>
</tr>

<tr>
<td>arguments</td>
<td>options passed to the exe from the cmd line</td>
</tr>

<tr>
<td>periodic_remove=time</td>
<td><ul><li> remove a job that has been in the queue for more than 100 hours e.g.(time() - QDate) &gt; (100<em>3600):</em></li><em> remove jobs that have been running for more than two hours e.g. periodic_remove = (JobStatus == 2 ) &amp;&amp; (time() - EnteredCurrentStatus) &gt; (2</em>3600) </ul></td>
</tr>

<tr>
<td>queue</td>
<td>indicates to create a job</td>
</tr>

</tbody>
</table></div>


<h3> Useful commands to manage and check the job's status.</h3>
<!--
<!--#for the dropdown wrapper
<details open> 
<summary>example1 of dropdown</summary> <!--for the dropdown title
<br>
csv
{{ read_csv('tier3docs/sshlogin/new/htc-cmdline.csv') }}
</details>
<br>
-->

{{ read_csv('tier3docs/sshlogin/new/htc-cmdline.csv') }}

