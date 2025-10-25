# Quickstart Guides

Welcome to the US ATLAS Analysis Facilities quickstart guides! Choose your
facility below to get started.

---

## Analysis Facilities

<div class="grid cards" markdown>

- :material-server-network:{ .lg .middle } **BNL Analysis Facility**

  ***

  Access instructions for the Brookhaven National Laboratory Analysis Facility

  **Location:** Brookhaven National Laboratory, NY

  **Login:** `ssh <username>@atl-dev01.bnl.gov`

  [:octicons-arrow-right-24: Get Started](ssh2BNL.md)

- :material-school:{ .lg .middle } **UChicago Analysis Facility**

  ***

  Access instructions for the University of Chicago Analysis Facility

  **Location:** University of Chicago, IL

  **Login:** `ssh login.af.uchicago.edu`

  [:octicons-arrow-right-24: Get Started](UChicago.md)

- :material-chip:{ .lg .middle } **SLAC Analysis Facility**

  ***

  Access instructions for the SLAC National Accelerator Laboratory Analysis
  Facility

  **Location:** SLAC National Accelerator Laboratory, CA

  **Login:** `ssh <username>@sdf-login.slack.stanford.edu`

  [:octicons-arrow-right-24: Get Started](ssh2SLAC.md)

</div>

---

## What's an Analysis Facility?

US ATLAS hosts three shared Tier 3 computing spaces at BNL, SLAC, and UChicago,
also known as Analysis Facilities (AF). These three facilities are available to
all US ATLAS physicists and computer scientists.

### Common Features

All three facilities provide:

- :material-login: SSH access to interactive nodes
- :material-run-fast: Batch job submission systems
- :material-database: Access to ATLAS data
- :material-harddisk: Private data storage
- :material-application: ATLAS/CERN software via CVMFS
- :material-cloud: Grid middleware and Rucio clients
- :material-language-python: Machine Learning packages
- :material-laptop: JupyterLab environments

!!! tip "Need Help?"

    See our [Getting Help](../GettingHelp.md) page for support options and how to reach the ATLAS AF team.

---

## Quick Comparison

| Feature               | BNL               | UChicago              | SLAC                         |
| --------------------- | ----------------- | --------------------- | ---------------------------- |
| **Batch System**      | HTCondor          | HTCondor              | SLURM                        |
| **Interactive Nodes** | atl-dev01.bnl.gov | login.af.uchicago.edu | sdf-login.slack.stanford.edu |
| **JupyterLab**        | ✓                 | ✓                     | ✓                            |
| **GPUs**              | ✓                 | ✓                     | ✓                            |
| **Xcache**            | 60TB              | 37.5TB                | 20TB                         |

---

## Before You Begin

!!! warning "Account Required"

    You need an approved account to access any of the Analysis Facilities. See [User Onboarding](../UserOnboarding/account.md) for details on applying for user accounts at BNL, SLAC, and UChicago.

### Prerequisites

Before accessing any facility, ensure you have:

- [ ] An approved user account
- [ ] SSH key pair generated (ed25519 or ecdsa recommended)
- [ ] Public key uploaded to the facility portal
- [ ] Basic familiarity with Linux/Unix command line
- [ ] (Optional) X.509 grid certificate for ATLAS data access
