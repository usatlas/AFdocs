# login to SLAC
# =============

# ssh to centos7 machines at SLAC
ssh -Y centos7.slack.stanford.edu

# get the source code
# ===================

cd /nfs/slack/g/atlas/u02/$USER
cp -pR /nfs/slack/g/atlas/u02/yesw/T3-Example-SLAC
cd T3-Example-SLAC


# setup
# =====

# ssh to centos7 machines at SLAC
ssh -Y centos7.slack.stanford.edu

export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
source $ATLAS_LOCAL_ROOT_BASE/user/atlasLocalSetup.sh
asetup AnalysisBase,21.2.81


# build
# =====
cmake src
make
ls bin/
bin/Exam_JetsPlot -h


# prepare input files
# ===================
lsetup rucio
voms-proxy-init -voms atlas -valid 95:00
dset=data16_13TeV:data16_13TeV.00311481.physics_Main.merge.DAOD_SUSY15.f758_m1616_r8669_p3185_tid11525262_00
rucio list-file-replicas --rse SLACXRD_LOCALGROUPDISK --protocols root $dset > dset-outside.txt
sed 's#griddev03.slack.stanford.edu:2094#atlrdr1#' dset-outside.txt > dset-inside.txt
head dset-inside.txt


# run jobs interactively
# ======================
mkdir Interactive-Job
cd Interactive-Job
# take one input file in "dset-inside.clist"
inputFile=root://atlrdr1//xrootd/atlas/atlaslocalgroupdisk/rucio/data16_13TeV/f9/bd/DAOD_SUSY15.11525262._000003.pool.root.1
../bin/Exam_JetsPlot $inputFile > myjob.log 2>&1
ls -l

root -l  myOutputFile.root
root [1] .ls
TFile**         myOutputFile.root
 TFile*         myOutputFile.root
  KEY: TH1D     h_njets_raw;1
  KEY: TH1D     h_mjj_raw;1
root [2] h_mjj_raw->Draw();
root [3] .qqq


cd -

# run jobs in batch system
# ========================
cd LSF-Job
cat test-LSF.sh
bsub -R 'centos7' -q atl-analq < test-LSF.sh

# check your job status
bjobs jobID

ls -l

root -l myOutputFile.root
