#!/bin/bash

export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh
asetup Athena,24.0.53,here

inputdir="/data/selbor/EVNT_StaticDir/"
outputdir="/home/selbor/benchmarks/benchmark_TRUTH/100xxx/100001/"
seed=1001

rm -rf ${outputdir}
mkdir -p ${outputdir}
cp mc* SUSY_*.py ${outputdir}
cd ${outputdir}
Derivation_tf.py --CA True --inputEVNTFile ${inputdir}EVNT.root --outputDAODFile=TRUTH3.root --formats TRUTH3
