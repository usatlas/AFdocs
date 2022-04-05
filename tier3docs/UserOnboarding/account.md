# Apply for computer accounts at AFs

All three facilities currently require users to register for a computing account, and the process is different for each.
You are free to sign up for an account at each facility, but please contact your advisor if you are unsure of which site to use. 
This section will provide a brief description of the process of getting signed up to use the facilities.

<!--
# Table of Contents

  - [Brookhaven National Lab](#BNL)
  - [University of Chicago](#UChicago)
  - [SLAC National Accelerator Laboratory](#SLAC)
-->

## <span id="BNL"></span> Brookhaven National Lab

Brookhaven National Lab has two types of accounts. 1) lightweight Federated Identity account for accessing Jupyter instance at BNL SDCC and 2) full SDCC account which includes access to Jupyter as well as ssh access to analysis facility.

#### Lightweight Federated Identity Account

The Federated Identity account is quicker to get and users connect BNL AF resources only through  the Jupyter Hub instance. Further details are found here: [BNL Federated ID Account](account/BNLFederatedID.md)

#### Full SDCC Account

The main site for new user sign-up for a full SDCC account is here: [BNL New User Account](https://www.sdcc.bnl.gov/information/getting-started/new-user-account)

Applying for a BNL computing account is a multi-step process. You will need to go through the following steps:

- Register for a Guest Number (if you don't already have a valid Life or Guest Number)
    - Same for as if you were going to visit BNL campus
    - Most likely will need to upload photos of identification
    - Non-citizens will need to upload your CV
- Complete CyberSecurity training and Computer Use agreement
- Sign up for a New User Account
    - Complete directly on the BNL New User Account site above

## <span id="UChicago"></span> University of Chicago

The UChicago AF user account signup process is much shorter than the other two labs, but still requires approval (which can take a few days).
The website containing sign-up information is here: [UChicago AF Website](https://af.uchicago.edu/).

The process is as follows:

- Account Creation
  - Multiple ways to sign up
  - Should use CERN email/info for quicker turnaround
- Upload public SSH key
  - Necessary for access

## <span id="SLAC"></span> SLAC National Accelerator Laboratory

Information about ATLAS at SLAC and their registration process can be found here: [SLAC ATLAS Support Center](https://atlas.slac.stanford.edu/atlas-support-center)

Similar to BNL, the process for signing up for access to SLAC AF is a two-step process:

- User Registration
    - Same as if you were to visit SLAC campus
- Computer Account
    - Fill out a Computer Account Request Form
    - Send to Charles Young (SLAC's designated ATLAS host)

<!--
<a name="sdf"></a><span style="color:orange">SDF: New SLAC computing environment and change to SLAC computing account</span>

SLAC is building a new computing facility - SLAC Shared Scientific Data Facility (SDF). On the technical side, it is an HPC environment built upon SLURM, Lustre and InfiniBand. Future US ATLAS resource at SLAC will be invested at SDF. At this stage, we would like to ask the JupyterLab users at the SLAC AF to prepare yourselves to login and switch to use JupyterLab at SDF ASAP by following the instruction below.

1. SDF will use a new identity management system (aka <span style="color:red">"SLAC ID"</span> - it will be a computer account to login to everything at SLAC). If you already have a SLAC Windows account, you are all set (SLAC ID = SLAC Windows account) and go to the next step. If you don't have a SLAC Windows account, please go to [SLAC SDF page and click "Accounts Portal"](https://sdf.slac.stanford.edu/public/doc/#/accounts-and-access?id=access). After this, give it a hour for the changes to be proprogated through SLAC computing.

2. `ssh sdf-login01.slac.stanford.edu` (or `sdf-login02`) using your "SLAC ID". The first time you login, a new home directory of 25GB will be created automatically. You can then logout and follow the JupyterLab link below.

What will happen to your GPFS or AFS spaces? The ATLAS GPFS spaces will be accessible at SDF. It just won't be your home directory. For AFS spaces, you will need to manually copy your files in AFS to SDF since SDF does not support AFS.


<span style="color:blue">Note: Except the JupyterLab, the existing computing accounts and environment for ATLAS will continue until the hardware retires, which is a year or two from now (September
2020).</span>
-->