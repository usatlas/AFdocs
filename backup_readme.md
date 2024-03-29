<style>
  #introMore {display: none;}
  #acctsMore {display: none;}
</style>

<script type="text/javascript" src="/tier3docs/scripts/readMoreOrLess.js"></script>

# Public Documentation for US ATLAS Analysis Facilities

<b>[Privacy Disclaimer](privacyDisclaimer)</b>

## Introduction to the US ATLAS Shared Tier 3s
US ATLAS hosted two shared Tier 3 at BNL and SLAC, also known as Analysis Facilities (AF). These
two faclities are available to all US ATLAS physicists and computer scientists. 
<span id="introLess">...</span><span id="introMore">They are
organized and managed to support US ATLAS users' need for computing resources including login,
run interactive and batch jobs, access ATLAS data, store private data, etc.
<br><br>
These three facilities also support tools specific for users analysis, including ATLAS/CERN
software in CVMFS, Grid middleware, Rucio clients, Machine Learning packages, MPI, Jupyter
Lab with PyROOT, Xcache with auto data discovery, GPUs, etc.
<br><br>
The three facilites are backed by staff to support software environments, unix systems and
storage.</span>

<!-- <button onclick="readMoreOrLess('introLess', 'introMore', 'introBtn')" id="introBtn">More</button> -->

This documentation includes the following:

     * [User Onboarding](UserOnboarding): details the process of applying for user accounts at BNL, SLAC, and UChicago
     * [Data Storing, Accessing, and Sharing](doma): explains the ways users can use their ATLAS data at AFs
     * [Jupyter at Analysis Facilities](jupyter): highlights the different aspects of jupyter and how to use it at AFs
     * [Data Analysis Tutorials](Tutorial-2019Aug): step-by-step tutorials on using AFs for analyses
     * [Containers](Containers): detailed information on container-based data processing and how to use them at AFs
     * [FAQ](faus-tips): answers to frequently asked questions

If you would like some additional help using AFs, you can reach ATLAS/AF staff on our Mattermost page [US-sharedtier3](https://mattermost.web.cern.ch/us-shared-tier3/channels/town-square).

<!--

## Apply computer accounts at BNL and/or SLAC
The processes can take days as both BNL and SLAC are DOE national labs. Do NOT wait until the 
last minute.

<span id="acctsLess"></span>
<span id="acctsMore">
Applying BNL computing accounts is a multiple-step process. 
[The steps are summarized at here](https://www.sdcc.bnl.gov/#accounts)<br>
<br>
[Applying SLAC computing accounts](https://atlas.slac.stanford.edu/atlas-support-center)
is a two-step process: becoming a SLAC laboratory user, and then obtain computing account(s).
</span>

<button onclick="readMoreOrLess('acctsLess', 'acctsMore', 'acctsBtn')" id="acctsBtn">More</button>

### <a name="sdf"></a><span style="color:orange">SDF: New SLAC computing environment and change to SLAC computing account</span>

SLAC is building a new computing facility - SLAC Shared Scientific Data Facility (SDF). On the technical side, it is an HPC environment built upon SLURM, Lustre and InfiniBand. Future US ATLAS resource at SLAC will be invested at SDF. At this stage, we would like to ask the JupyterLab users at the SLAC AF to prepare yourselves to login and switch to use JupyterLab at SDF ASAP by following the instruction below.

1. SDF will use a new identity management system (aka <span style="color:red">"SLAC ID"</span> - it will be a computer account to login to everything at SLAC). If you already have a SLAC Windows account, you are all set (SLAC ID = SLAC Windows account) and go to the next step. If you don't have a SLAC Windows account, please go to [SLAC SDF page and click "Accounts Portal"](https://sdf.slac.stanford.edu/public/doc/#/accounts-and-access?id=access). After this, give it a hour for the changes to be proprogated through SLAC computing.

2. `ssh sdf-login01.slac.stanford.edu` (or `sdf-login02`) using your "SLAC ID". The first time you login, a new home directory of 25GB will be created automatically. You can then logout and follow the JupyterLab link below.

What will happen to your GPFS or AFS spaces? The ATLAS GPFS spaces will be accessible at SDF. It just won't be your home directory. For AFS spaces, you will need to manually copy your files in AFS to SDF since SDF does not support AFS.

<span style="color:blue">Note: Except the JupyterLab, the existing computing accounts and environment for ATLAS will continue until the hardware retires, which is a year or two from now (September 2020).</span>

## Data analysis tutorials 
[A tutorial of analysis example at Tier3s of BNL/SLAC is available at here](Tutorial-2019Aug).
It was initially given at the Aug. 2019 US ATLAS Week at University of Massachusetts Amherst.

## JupyterLab at AFs
Documents, examples and entry points of the [JupyterLab at BNL and SLAC](jupyter/JupyterAtTier3s.md). 

-->