## User instructions for obtaining a BNL Federated ID Account 

BNL now has a Jupyter instance that allows ATLAS members to sign in with their CERN or SLAC computer credentials.

### Prerequisites

As a prerequisite, you will need to obtain an [ORCID](https://orcid.org) number. [CERN](https://scientific-info.cern/submit-and-publish/persistent-identifiers/orcid) encourages all those involved in scholarly communication (i.e. all ATLAS members) to get an[ ORCID](https://orcid.org). Please use this[ ](https://orcid.org/register)link to register: <https://orcid.org/register>

BNL requires multi-factor authentication (MFA) to access these accounts. Currently Federated accounts from CERN or SLAC are accepted. 

If you have an existing SDCC account, you will need to enable MFA for your SDCC account by following the procedure described here: <https://www.sdcc.bnl.gov/information/unified-multi-factor-authentication>

You will need to make certain that your CERN account is set up for MFA. See this link for further details: <https://security.web.cern.ch/recommendations/en/2FA.shtml> 

SLAC also has a multi-factor authentication option. You will need to enroll in SLAC DUO. Instructions on setting up Two Step Authentication @ SLAC can be here: <https://www-internal.slac.stanford.edu/twostep/> 



It will typically take one to two business days to get a light-weight BNL Federated ID account.

### Apply for account 

To start: connect to  [https://federated.sdcc.bnl.gov/ ](https://federated.sdcc.bnl.gov/)

You will first come to this authorization page:

![InitialSigninPage.png](InitialSigninPage.png?fileId=25551496#mimetype=image%2Fpng&hasPreview=true)

If you already have an SDCC account, you can use it to log in by entering username/password on the left side of this page.

To use your CERN login, select the CERN button on the right. This will send you to a CERN login page (NB: MFA will be required at that point).

Once you have successfully logged in, you will be directed to an account registration page. On this page, all fields are required, in particular the ORCID as shown below.

![ORCID.png](ORCID.png?fileId=25551506#mimetype=image%2Fpng&hasPreview=true)

If you have an existing SDCC Account, please select the "Yes" button and enter your SDCC username. This will help us map your federated login to this existing account.

![SDCCAccountQuestion.png](SDCCAccountQuestion.png?fileId=25551516#mimetype=image%2Fpng&hasPreview=true)

Finally, as a verification step, you will be required to enter the designated point of contact's name. This name must not be shared with anyone outside the ATLAS collaboration. It can be found here: <https://twiki.cern.ch/twiki/bin/view/Atlas/BNLJupyter>.

![PointofContact.png](PointofContact.png?fileId=25551526#mimetype=image%2Fpng&hasPreview=true)

Once you submit your account request, you will receive an email from RT-RACF-UserAccounts@bnl.gov with subject line starting with "**Lightweight User Account Request for ATLAS Federated ID from** *<your name>*." You will be informed through the RT ticket via email when your account has been created. At that point, you will be able to log in with your federated credentials on the jupyterhub portal at <https://atlas-jupyter.sdcc.bnl.gov/>.
