# login
# =====

# ssh to spar machines at BNL
ssh -Y atlasgw.bnl.gov
rterm -i

# get the source code
# ===================

cd /atlasgpfs01/usatlas/data/$USER
cp -pR /atlasgpfs01/usatlas/data/yesw2000/T3-Example-BNL .
cd T3-Example-BNL


# setup
# =====

# uncomment the following lines if the command setupATLAS is not defined yet

# export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
# alias setupATLAS='source $ATLAS_LOCAL_ROOT_BASE/user/atlasLocalSetup.sh'

setupATLAS --quiet
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
dset=data18_13TeV:data18_13TeV.00348885.physics_Main.deriv.DAOD_EXOT12.f937_m1972_p3553_tid14278917_00
pnfs_ls.py $dset -o dset-inside.clist
head dset-inside.clist


# run jobs interactively
# ======================
mkdir Interactive-Job
cd Interactive-Job
# take one input file in "dset-inside.clist"
inputFile=root://dcgftp.usatlas.bnl.gov:1096/pnfs/usatlas.bnl.gov/LOCALGROUPDISK/rucio/data18_13TeV/da/ea/DAOD_EXOT12.14278917._000001.pool.root.1
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
cd Condor-Job
ls -l $X509_USER_PROXY
cat test-condor.job
condor_submit test-condor.job

# check your job status  (idle => run => done (disappeared in condor_q))
condor_q

ls -l

root -l myOutputFile.root
