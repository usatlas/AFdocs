#/bin/bash

cp ~data/selbor/ReqFiles/mc* .
cp ~data/selbor/ReqFiles/SUSY_*.py .

export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh
asetup AthGeneration,23.6.34,here

outputdir="/home/selbor/benchmarks/benchmark_EVNT/100xxx/100001/"
seed=1001

rm -rf ${outputdir}
mkdir -p ${outputdir}
cp mc* SUSY_*.py ${outputdir}
cd ${outputdir}
Gen_tf.py --ecmEnergy=13000.0 --jobConfig=${outputdir}  --outputEVNTFile=EVNT.root --maxEvents=10000 --randomSeed=${seed}
