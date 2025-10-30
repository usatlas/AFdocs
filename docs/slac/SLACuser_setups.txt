#!/bin/sh
# This file should be put in $HOME/notebooks/.user_setups. It will be used
# by Jupyter kernels

# source ATLAS environment if we are using PYTHON_VER = 2

cd /gpfs/slac/atlas/fs1/u/$(id -un)

if [ ! -z "$PYTHON_VER" -a $PYTHON_VER -eq 2 ]; then
    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    source $ATLAS_LOCAL_ROOT_BASE/user/atlasLocalSetup.sh --quiet
    asetup AnalysisBase,21.2.111 > /dev/null 2>&1
fi
