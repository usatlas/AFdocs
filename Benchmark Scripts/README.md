# Benchmark Scripts:
This directory contains four kind of jobs that are ran periodically at The UChicago AF:
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
The following scripts are used to run interactive jobs at UChicago:
- script_rucio.sh
- to_run_centos_interactive.sh

## Batch Jobs
As outlined in the documentation, to run batch jobs we need an executable file and a submission file. For benchmarking purposes a third script was written. Information about these can be found in the following subsections.
### Executable Files
The following scripts are used as the executable files for batch job submissions at UChicago:
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
