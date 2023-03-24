## HTCondor user's guide
### Use condor within eventloop
If you are using EventLoop to submit your code to the Condor batch system you should replace your submission driver line with something like the following:

```bash
EL::CondorDriver driver;
job.options()->setString(EL::Job::optCondorConf, "getenv = true\naccounting_group = group_atlas.<institute>");
driver.submitOnly( job, "yourJobName”);
```
### Useful commands for the jobs submission file
<table>
<thead><tr>
<th>option</th>
<th>What is it for?</th></tr>
</thead><tbody>
    <tr><td>transfer_output_files =<file1,file2.../></td>
    <td>When it isn’t specified, it automatically transfers back all files that have been created or modified in the job’s temporary working directory.</td></tr>
    <tr><td>transfer_input_file</td>
    <td>HTCondor transfers input files from the machine where the job is submitted to the machine chosen to execute the job</td></tr>
    <tr><td>when_to_transfer_output</td>
    <td> - on_exit: (default) when the jobs ends on its own
    - on_exit_or_evict: if the job is evicted from a machine</td> </tr>
    <tr><td>should_transfer_files</td>
        <td>- yes: always transfers files to the remote working directory
            - if_needed: (default) access t files from a shared file system if possible, otherwise it will transfer the file
            -  :no : disables file transfe
            - command specifies whether HTCondor should assume the existence of a file system shared by the submit machine and the execute machine.</td> </tr>
    <tr><td>arguments</td>
    <td>options passed to the exe from the cmd line</td> </tr>
    <!--<tr><td>notify_user = <your_email_address> </td>
    <td>**add meaning**</td> </tr>-->
    <!--<tr><td>max_idle</td>
    <td>mean2</td> </tr>-->
    <!--<tr><td>MaxDuration = 3600</td>
    <td>mean2</td> </tr>-->
    <tr><td>periodic_remove = time</td>
    <td>- remove a job wh has been in t queue for more tn 100 hours
e.g. (time() - QDate) > (100 * 3600):
- remove jobs that have been running f more tn tw hours
e.g. periodic_remove = (JobStatus == 2) && (time() - EnteredCurrentStatus) > (2 * 3600)</td> </tr>
    <tr><td>queue</td>
    <td>indicates to create a job</td></tr>
</tbody></table>
<!--code-->

### Useful commands to manage jobs
<!--
<table>
<thead><tr>
<th>option</th>
<th>What is it for?</th></tr>
</thead><tbody>
    <tr><td>condor_release</td>
    <td>
        <li>- releases t job fm t htcondor job queue tt were prev placed in hold state (only owner or super users can release)</li>
        <li>- version</li>
        <li>- user # to specified user</li>
        <li>- debug # sent debugging inf to stderr based on t value oft config var tool_debug</li>
        <li>- constraint expression # match t job ClassAd expression constraint</li>
        <li>- all</li></td>
    <tr><td>condor_ssh_to_job jobid filename</td>
    <td><li>- while running n check on realtime</li>
        <li>- attach to it w gdb to inspect the stack</td> </tr></li>
    <tr><td>condor_ssh_to_job jobid </td>
    <td>- eg. slot1_3@c008.af.uchicago.edu
</td> </tr>
    <!--<tr><td>fun1</td>
    <td>mean2</td> </tr>
    <tr><td>fun1</td>
    <td>mean2</td> </tr>
    <tr><td>fun1</td>
    <td>mean2</td> </tr>
    </td></tr>
</tbody></table>
-->

{{ read_csv('tier3docs/sshlogin/new/htc-cmdline.csv') }}





