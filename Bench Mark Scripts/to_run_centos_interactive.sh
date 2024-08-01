#!/bin/bash

export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
inputdir=/data/selbor/EVNT_StaticDir/
outputdir=/home/selbor/benchmarks/benchmark_TRUTH_centos7/100xxx/100001/
seed=1001

curr_time=$(date +"%Y.%m.%dT%H.%M.%S")

source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh -b -c centos7 -m /data:/data -r "asetup AthDerivation,21.2.178.0,here && \
rm -rf ${outputdir} && \
mkdir -p ${outputdir} && \
cd ${outputdir} && \
ls -ltrh ${inputdir}EVNT_centos.root && \
Reco_tf.py --inputEVNTFile ${inputdir}EVNT_centos.root --outputDAODFile TRUTH3.root --reductionConf TRUTH3" 2>&1 | tee /data/selbor/LogFiles/TRUTH3_centos7_interactive/$curr_time.log
