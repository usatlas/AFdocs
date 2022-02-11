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


<span style="color:blue">Note: Except the JupyterLab, the existing computing accounts and environment for ATLAS will continue until the hardware retires, which is a year or two from now (September
2020).</span>