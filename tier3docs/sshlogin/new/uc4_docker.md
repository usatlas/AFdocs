## Using Docker / Singularity containers (Advanced)

Some users may want to bring their own container-based workloads to the Analysis
Facility. We support both Docker-based jobs as well as Singularity-based jobs.
Additionally, the CVMFS repository unpacked.cern.ch is mounted on all nodes.

If, for whatever reason, you wanted to run a Debian Linux-based container on the
Analysis Facility, it would be as simple as the following Job file:

```
universe                = docker
docker_image            = debian
executable              = /bin/cat
arguments               = /etc/hosts
should_transfer_files   = YES
when_to_transfer_output = ON_EXIT
output                  = out.$(Process)
error                   = err.$(Process)
log                     = log.$(Process)
request_memory          = 1000M
queue 1
```

Similarly, if you would like to run a Singularity container, such as the ones
provided in the unpacked.cern.ch CVMFS repo, you can submit a normal vanilla
universe job, with a job executable that looks something like the following:

```
#!/bin/bash
singularity run -B /cvmfs -B /home /cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlas/rucio-clients:default rucio --version
```

Replacing the `rucio-clients:default` container and `rucio --version` executable
with your preferred software.
