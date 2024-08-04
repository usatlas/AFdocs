#!/bin/bash

# Needed lines since we aren't in lsplus
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase

# Defines the input directory
inputdir=/data/selbor/EVNT_StaticDir/

# Defining the output directory
outputdir=/home/selbor/benchmarks/benchmark_TRUTH_centos7/100xxx/100001/

# Defining the seed
seed=1001


# Defining the current time; used when naming files
curr_time=$(date +"%Y.%m.%dT%H.%M.%S")

# Creates the container using centos7
# Output is saved in the log file with the name set up curr_time
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh -b -c centos7 -m /data:/data -r "asetup AthDerivation,21.2.178.0,here && \
Reco_tf.py --inputEVNTFile ${inputdir}EVNT_centos.root --outputDAODFile TRUTH3.root --reductionConf TRUTH3" 2>&1 | tee /data/selbor/LogFiles/TRUTH3_centos7_interactive/$curr_time.log

# Creates a new, clean, output directory
mkdir -p ${outputdir}

