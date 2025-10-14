#!/bin/bash

# Sets up the environment
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase

# Defines where the input files are located
inputdir=/data/selbor/EVNT_StaticDir/

# Defines where the output files will be going
outputdir=/home/selbor/benchmarks/benchmark_TRUTH_centos7/100xxx/100001/

# Defines our seed parameter
seed=1001

# Creates the using centos7
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh -b -c centos7 -m /data:/data -r "asetup AthDerivation,21.2.178.0,here && \
Reco_tf.py --inputEVNTFile ${inputdir}EVNT_centos.root --outputDAODFile TRUTH3.root --reductionConf TRUTH3" 

# Creates a new, clean, output directory
mkdir -p ${outputdir}


