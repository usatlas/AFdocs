#/bin/bash


# Copies the necessary files into the directory:
# /data/selbor/ReqFiles/
cp ~data/selbor/ReqFiles/mc* .
cp ~data/selbor/ReqFiles/SUSY_*.py .

# Since we aren't working in lxplus we need the following two lines: 
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh

# Sets up our ATLAS Release and version
asetup AthGeneration,23.6.34,here

# Defining out output directory
outputdir="/home/selbor/benchmarks/benchmark_EVNT/100xxx/100001/"
# Defining our seed
seed=1001

# Removes the output directory in case it's still there
rm -rf ${outputdir}

# Makes the directory to store files
mkdir -p ${outputdir}

# Copies the necessary script to the output directory
cp mc* SUSY_*.py ${outputdir}

# Changes directory into the output directory
cd ${outputdir}

# Runs the job using all the necessary parameters we defined above
Gen_tf.py --ecmEnergy=13000.0 --jobConfig=${outputdir}  --outputEVNTFile=EVNT.root --maxEvents=10000 --randomSeed=${seed}
