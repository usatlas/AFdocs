# Benchmark Scripts:
Contains information about four example jobs that are being run at the UChicago AF. The jobs run periodically, every six hours, with the aid of crontab.
## Workflow
When a crontab file access one of the scripts in this directory is works in the following way:
1. Reads the script the user specifies in their script:
  - Suppose the crontab is set to run a batch job, then it will read /home/selbor/benchmarks/TRUTH3/script_TRUTH.sh
    ```bash
    #!/bin/bash
    
    condor_submit /home/selbor/benchmarks/TRUTH3/benchmark_TRUTH.sub
    ```
2. The contents of /home/selbor/benchmarks/TRUTH3/script_TRUTH.sh file will submit the submission file; /home/selbor/benchmarks/TRUTH3/benchmark_TRUTH.sub
3. The contents of the submission file will be read and the executable file will be used for the job; /home/selbor/LogFiles/benchmarks/TRUTH/run_truth3.sh

If the user wants to run this job interactively then, within the directory the executable file is located, the user should run:
```console
./run_truth3.sh
```
For interactive jobs, like for the Rucio Downloads, the script that the crontab reads just contains all of the commands one would enter in the console.

## Type of Jobs
Each of the jobs listed below have their respective directories with everything needed to run them, either interactively or in the batch:
- EVNT: 
  - Batch
- TRUTH3:
  - Batch
- Rucio:
  - Interactive
- TRUTH3_centos7:
  - Batch
  - Interactive

## Interactive Jobs
The following scripts are used to run interactive jobs:
- script_rucio.sh
- to_run_centos_interactive.sh

## Batch Jobs
As outlined in the documentation, to run batch jobs we need an executable file and a submission file. For benchmarking purposes a third script was written. Information about these can be found in the following subsections.
### Executable Files
The following scripts are used as the executable files for batch job submissions:
- run_EVNT.sh
- run_truth3.sh
- to_run_centos.sh

### Submission Files
The submission files all follow the format that was outlined in the documentation. The following is a list of the submission files used:
- benchmark_EVNT.sub
- benchmark_TRUTH.sub
- benchmark_TRUTH_centos7.sub

### Crontab Scripts:
To run the batch jobs periodically the following scripts are accessed by a crontab file:
- script_TRUTH.sh
- script_EVNT.sh
- script_TRUTH3_centos.sh
- to_run_centos_interactive.sh

## Cron-Jobs
The scripts are ran every six hours, this is done using a crontab. Below you'll find the crontab file used:

```bash
0 */6 * * * /home/selbor/benchmarks/Rucio/script_rucio.sh

0 */6 * * * /home/selbor/benchmarks/TRUTH3/script_TRUTH.sh

0 */6 * * * /home/selbor/benchmarks/EVNT/script_EVNT.sh

0 */6 * * * /home/selbor/benchmarks/TRUTH3_centos7/script_TRUTH3_centos.sh

0 */6 * * * /home/selbor/benchmarks/TRUTH3_centos7/to_run_centos_interactive.sh
```
