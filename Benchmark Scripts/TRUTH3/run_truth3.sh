#!/bin/bash

# Sets up our environment
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh

# Sets up the ATLAS release and version
asetup Athena,24.0.53,here

# Input files are found in the input directory
inputdir="/data/selbor/EVNT_StaticDir/"

# Output files will be stored in the output directory
outputdir="/home/selbor/benchmarks/benchmark_TRUTH/100xxx/100001/"
# Defining our seed parameter
seed=1001

# Forcefully removes any existing files in the output directory, if there are any.
rm -rf ${outputdir}

# Creates a new, clean, output directory
mkdir -p ${outputdir}

# Copies the required script and files into the output directory
cp mc* SUSY_*.py ${outputdir}

# Goes into the output directory
cd ${outputdir}

# Runs our process with all of the previously defined parameters
Derivation_tf.py --CA True --inputEVNTFile ${inputdir}EVNT.root --outputDAODFile=TRUTH3.root --formats TRUTH3
