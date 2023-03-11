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
    <td>htcondor transfers input files fm t machine where t job is submittet to t machine chosen to execute the job</td></tr>
    <tr><td>when_to_transfer_output</td>
    <td> - on_exit: (default) wn t jobs ends on its own
    - on_exit_or_evict: if t job is evicted fm a machine</td> </tr>
    <tr><td>should_transfer_files</td>
        <td>- yes: always transfers files to the remote working directory
- if_needed: (default) access t files from a shared file system if possible, otherwise it will transfer the file
- :no : disables file transfe
- command specifies whether HTCondor should assume the existence of a file system shared by the submit machine and the execute machine.</td> </tr>
    <tr><td>arguments</td>
    <td>options passed to the exe from the cmd line</td> </tr>
    <tr><td>notify_user = <your_email_address> </td>
    <td>**add meaning**</td> </tr>
    <tr><td>max_idle</td>
    <td>mean2</td> </tr>
    <tr><td>MaxDuration = 3600</td>
    <td>mean2</td> </tr>
    <tr><td>periodic_remove = time</td>
    <td>- remove a job wh has been in t queue for more tn 100 hours
e.g. (time() - QDate) > (100 * 3600):
- remove jobs that have been running f more tn tw hours
e.g. periodic_remove = (JobStatus == 2) && (time() - EnteredCurrentStatus) > (2 * 3600)</td> </tr>
    <tr><td>queue</td>
    <td>indicates to create a job</td></tr>
</tbody></table>

[//]: # (for reference table)
[//]: # ( <tr><td>fun1</td> )
[//]: # ( <td>mean2</td> </tr> )

### Useful commands to manage jobs
condor_release

- releases t job fm t htcondor job queue tt were prev placed in hold state (only owner or super users can release)
- version
- user # to specified user
- debug # sent debugging inf to stderr based on t value oft config var tool_debug
- constraint expression # match t job ClassAd expression constraint
- all

condor_ssh_to_job jobid filename

- while running n check on realtime 
- attach to it w gdb to inspect the stack

condor_ssh_to_job jobid 

- eg.  slot1_3@c008.af.uchicago.edu

condor_submit –interactive

- sets up t job env n input files
- gives a command propmt where you can tn start job manually to see what happns

condor_submit -append input in A,B,C

condor_q

condor_qedit

- modify job attributes. i.e change t command line arguments like name of an output file(among many other things)
- check condor_q -long
	- condor_qedit Cmd = path_to_executable #changes it 





condor_q -long

- check job's ClassAd attributes to edit t attributes
	- e.g. 

condor_q -analyze 27497829

- why is not running n +info

condor_q -better-analyze 

condor_q -hold  16.0

- reason job 16.0 is in t hold state

condor_q -hold user

- ID, OWNER, HELD_SINCE, HOLD_REASON
