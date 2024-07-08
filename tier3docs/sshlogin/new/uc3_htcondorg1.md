## HTCondor user's guide
### Use condor within eventloop
If you are using EventLoop to submit your code to the Condor batch system you should replace your submission driver line with something like the following:

```bash
EL::CondorDriver driver;
job.options()->setString(EL::Job::optCondorConf, "getenv = true\naccounting_group = group_atlas.<institute>");
driver.submitOnly( job, "yourJobName”);
```
### Useful attributes for the jobs submission file
| Option                  | What is it for?                                                                                                                                                                                                                                                                                                                                                                          |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| transfer_output_files=  | When it isn't specified, it automatically transfers back all files that have been created or modified in the job’s temporary working directory.                                                                                                                                                                                                                                          |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| transfer_input_files    | HTCondor transfer input files from the machine where the job is submitter to the machine chosen to execute the job                                                                                                                                                                                                                                                                       |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| when_to_transfer_output | <ul><li>on_exit:(default) when the job ends on its own</li><li>on_exit_or_evict: fit the job is evicted from the machine</li></ul>                                                                                                                                                                                                                                                       |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| should_transfer_files   | <ul><li>yes: always transfer files to the remote working directory</li><li>if_needed: (default) access the files from a shared file system if possible, otherwise it will transfer the file</li><li> no: disables file transfer </li><li>command specifies whether HTCondor should assume the existence of a file system shared by the submit machine and the execute machine.</li></ul> |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| arguments               | options passed to the exe from the cmd line                                                                                                                                                                                                                                                                                                                                              |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| periodic_remove=time    | <ul><li> remove a job that has been in the queue for more than 100 hours e.g.(time() - QDate) > (100*3600):</li> remove jobs that have been running for more than two hours e.g. periodic_remove = (JobStatus == 2 ) && (time() - EnteredCurrentStatus) > (2*3600) </li></ul>                                                                                                            |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| queue                   | indicates to create a job                                                                                                                                                                                                                                                                                                                                                                |
### Useful commands to manage and check jobs status.
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





