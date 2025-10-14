#!/bin/bash

# Sets up our environment
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
# shellcheck disable=SC1091
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh

# Sets up the ATLAS release and version
asetup Athena,24.0.53,here

# Input files are found in the input directory
inputdir="/data/selbor/EVNT_StaticDir/"

# Output files will be stored in the output directory
outputdir="/home/selbor/benchmarks/benchmark_TRUTH/100xxx/100001/"


# Runs our process with all of the previously defined parameters
Derivation_tf.py --CA True --inputEVNTFile ${inputdir}EVNT.root --outputDAODFile=TRUTH3.root --formats TRUTH3


# Creates a new, clean, output directory
mkdir -p ${outputdir}
