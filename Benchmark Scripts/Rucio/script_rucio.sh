#! /bin/bash

# Removes the existing directory in preparation for another download
rm -r mc23_13p6TeV.700866.Sh_2214_WWW_3l3v_EW6.deriv.DAOD_PHYSLITE.e8532_e8528_s4162_s4114_r14622_r14663_p6026_tid37222410_00/

# The following lines are needed since we aren't in xlplus
export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
export ALRB_localConfigDir=$HOME/localConfig

# Section makes use of our certificate
# shellcheck disable=SC1091
source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh
lsetup emi
echo "Wookiee13" | voms-proxy-init -voms atlas

# Sets up our data management system client
lsetup "rucio -w"

# Makes note of the current date and time; to be used in naming log files
curr_time=$(date +"%Y.%m.%dT%H.%M.%S")

# Begins the rucio download process
# Its outputs are saved in the /data/selbor/LogFiles/Rucio/ directory.
# The file's name is the date and time the process began
rucio download --rses AGLT2_LOCALGROUPDISK mc23_13p6TeV:mc23_13p6TeV.700866.Sh_2214_WWW_3l3v_EW6.deriv.DAOD_PHYSLITE.e8532_e8528_s4162_s4114_r14622_r14663_p6026_tid37222410_00 2>&1 | tee /data/selbor/LogFiles/Rucio/"$curr_time".log
