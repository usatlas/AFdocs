# Using Singularity

  - [Introduction](#Introduction)
      - [What are Containers?](#What_are_Containers)
      - [What is Singularity?](#What_is_Singularity)
  - [Installation of Singularity](#Installation_of_Singularity)
      - [Singularity on Linux OS](#Singularity_on_Linux_OS)
      - [Singularity on Mac OS](#Singularity_on_Mac_OS)
      - [Singularity on Windows 10](#Singularity_on_Windows_10)
          - [Installation of Windows Subsystem for Linux
            (WSL)](#Installation_of_Windows_Subsyste)
          - [Running Windows 10 build 19041 or
            higher or Windows 11](#Running_Windows_build)
          - [Installation of WSL2](#Installation_of_WSL2)
          - [Linux Distribution Installation on Windows](#Linux_Distro_Installation_on_Windows)
          - [Use the Installed Linux on Windows](#Use_the_Installed_Linux_on_Windo)
          - [Singularity Installation on
            WSL2](#Singularity_Installation_on_WSL2)
  - [Using Singularity](#Using_Singularity_AN1)
      - [Singularity Usage Help](#Singularity_Usage_Help)
      - [Cache Folders](#Cache_Folders)
      - [Binding Paths and Mounts](#Binding_Paths_and_Mounts)
      - [Examples](#Examples)
          - [Some Fun Exercise Examples](#Some_Fun_Exercise_Examples)
          - [Using Containers for LaTeX](#Using_Containers_for_LaTeX)
          - [Using Containers for Machine
            Learning](#Using_Containers_for_Machine_Lea)
      - [Using Containers through ARLB](#Using_Containers_through_ARLB)
  - [Explore Container Images](#Explore_Container_Images)
      - [Containers on CVMFS](#Containers_on_CVMFS)
      - [Containers on Docker Hub](#Containers_on_Docker_Hub)
      - [Containers on Singularity Hub and
        Library](#Containers_on_Singularity_Hub_an)
  - [Contained-based Jobs on the
    Grid](#Contained_based_Jobs_on_the_Grid)

</div>

# <span id="Introduction"></span> Introduction

## <span id="What_are_Containers"></span> What are Containers?

**Containers** are an operating system virtualization technology used to
package applications and their dependencies and run them in isolated
environments. Unlike Virtual Machines, they share the host OS kernel,
thus provide a **lightweight** method of packaging and deploying
applications in a standardized way across many different types of
infrastructure.

## <span id="What_is_Singularity"></span> What is Singularity?

**[Singularity](https://sylabs.io/)**
is a container platform. It allows you to create and run containers that
package up pieces of software in a portable and reproducible way. In
contrast to
**[Docker](https://docs.docker.com/)**,
Singularity does not give superuser privileges. And it can access to the
GPU on a host node in native speed.

You can build a container using Singularity on your laptop, and then run
it on the grid. You can also make use of many already existing container
images from different sources.

# <span id="Installation_of_Singularity"></span> Installation of Singularity

## <span id="Singularity_on_Linux_OS"></span> Singularity on Linux OS

Most Linux Distros should come with the Singularity. For example,
Singularity is already available on BNL/SLAC machines.

    cent7a(SLAC)$ singularity --version
    singularity version 3.5.3-1.1.el7

    spar0101(BNL)$ singularity --version
    2.6.1-dist

If it does not come with your Linux OS, you can find the installation
instruction for the version of 3.5 (the latest one currently):

<https://sylabs.io/guides/3.5/admin-guide/installation.html>

The singularity maintained in Linux distribution repos (via apt or yum)
tends to be older. If you like to install the latest version, you can
visit [the gitlab source
site](https://github.com/sylabs/singularity/releases)
to install from the source.

## <span id="Singularity_on_Mac_OS"></span> Singularity on Mac OS

Since Mac OS does not use Linux kernel, the Singularity for Linux does
not work here. However, a new Singularity Desktop for Mac OS has been
developed to take Linux-based containers. The installation instruction
can be found
[here](https://sylabs.io/singularity-desktop-macos/).
It is still a beta release, and distributed as a DMG file (Mac OS disk
image). The current beta release version is:

    MacOS$ singularity --version
    singularity version 3.3.0-rc.1.658.g7427b73f1.dirty

As stated on the page of [Singularity Desktop
MacOS](https://sylabs.io/singularity-desktop-macos/),
there are some limitations.

Run **singularity -h** to find the full available commands and options.
In comparison with the Singularity-3.5 on Linux, the Singularity on Mac
OS misses many commands such as **inspect** and **instance**.

## <span id="Singularity_on_Windows_10"></span> Singularity on Windows 10

In order to use Singularity on Windows, you need install a Linux distro
first. It could be achieved through [Windows Subsystem for Linux
(WSL)](https://docs.microsoft.com/en-us/windows/wsl/faq)
without involving a Virtual Machine. **WSL** is a new Windows 10 feature
that enables you to run native Linux command-line tools directly on
Windows. So it is not available for other old Windows such as Windows 7.

### <span id="Installation_of_Windows_Subsyste"></span> Installation of Windows Subsystem for Linux (WSL)

Please refer [the WSL installation guide for
Windows 10](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

First enable the option feature **Microsoft-Windows-Subsystem-Linux**.
Open **PowerShell as Administrator** and run:

    Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

When prompted restart the computer.

Then you can install your preferred Linux Distro, following [the link on
the Microsoft
store](https://docs.microsoft.com/en-us/windows/wsl/install-win10),
where there is no CentOS available. However, you can find the
installation guide for CentOS at
[TipsMake.com](https://tipsmake.com/install-centos-on-windows-10-wsl).
Or download directly [the zip file at
github](https://github.com/yuk7/CentWSL)
and following the instruction to install it.

Once your distro has been downloaded and installed, you will be prompted
to **create a new user account** together with its password to
[initialize the new Linux
distro](https://docs.microsoft.com/en-us/windows/wsl/initialize-distro).

### <span id="Running_Windows_build"></span> Running Windows 10 build 19041 or higher or Windows 11

In order to install WSL2, ensure that you must be running Windows 10...

   - For x64 systems: Version 1903 or later, with Build 18362.1049 or later.
   - For ARM64 systems: Version 2004 or later, with Build 19041 or later.

or Windows 11.

You can check your Windows version by opening
**Command Prompt** and running the **ver** command.

> 
> 
>     Microsoft Windows [Version 10.0.19587.1000]
>     (c) 2020 Microsoft Corporation. All rights reserved.
>     
>     C:\Users\Shuwei>ver
>     
>     Microsoft Windows [Version 10.0.19587.1000]

Actually the Windows build information has already be displayed on the
terminal top when the **Command Prompt** app is opened.

You can also check the Windows build info in PowerShell with command
**systeminfo**:

> 
> 
>     PS C:\Users\Shuwei> systeminfo | Select-String "^OS Name","^OS Version"
>     
>     OS Name:                   Microsoft Windows 10 Home Insider Preview
>     OS Version:                10.0.19587 N/A Build 19587

If your Windows build is lower than **18362** (for x64 systems) or 19041 (for ARM64 systems), 
you can use the [Windows Update Assistant](https://www.microsoft.com/software-download/windows10) 
to update your version of Windows.

### <span id="Installation_of_WSL2"></span> Installation of WSL2

You can find [the detailed instruction on installing WSL2 on
Windows](https://learn.microsoft.com/en-us/windows/wsl/install).
The first 2 requirements have already been discussed above. Next you
need:

  - Enable the 'Virtual Machine Platform' optional component
  - Set a distro to be backed by WSL2 using the command line
  - Verify what versions of WSL your distros are using

To Enable the **Virtual Machine Platform**, run **PowerShell as
Adminstrator** with:

    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

Then restart the computer.

Next set the Linux dsitro to WSL2 by the following command under
**PowerShell**:

    wsl --set-default-version 2

which may take a while to apply.

Now you can verify which WSL version used the Linux distro.

> 
>     PS C:\Users\Shuwei> wsl -v
>     WSL version: 2.0.9.0
>     Kernel version: 5.15.133.1-1
>     WSLg version: 1.0.59
>     MSRDC version: 1.2.4677
>     Direct3D version: 1.611.1-81528511
>     DXCore version: 10.0.25131.1002-220531-1700.rs-onecore-base2-hyp
>     Windows version: 10.0.19045.3803

### <span id="Linux_Distro_Installation_on_Windows"></span> Linux Distribution Installation on Windows

### <span id="Use_the_Installed_Linux_on_Windo"></span> Use the Installed Linux on Windows

Open **PowerShell under a regular user** and run **wsl**:

> 
> 
>     PS C:\Users\Shuwei> wsl
>     yesw2000@Home-Dell660:/mnt/c/Users/Shuwei$ echo $0
>     -bash
>     yesw2000@Home-Dell660:/mnt/c/Users/Shuwei$

which starts the Linux and enter **bash**.

You can also start the Linux by searching **wsl** or **bash** on the
Windows Start Search Box and click on **wsl Run command** or **bash Run
command**.

If the Linux is already running, you can run "bash" to enter the Linux:

> 
> 
>     PS C:\Users\Shuwei> wsl -l -v
>       NAME            STATE           VERSION
>     * Ubuntu-18.04    Running         2
>     PS C:\Users\Shuwei> bash
>     yesw2000@Home-Dell660:/mnt/c/Users/Shuwei$

After all terminals associated with the Linux have been closed, the
running Linux will stop then.

### <span id="Singularity_Installation_on_WSL2"></span> Singularity Installation on WSL2

Start the Linux distro on Windows, then install Singularity as the same
ways as on the Linux OS.

# <span id="Using_Singularity_AN1"></span> Using Singularity

## <span id="Singularity_Usage_Help"></span> Singularity Usage Help

You can find the Singularity usage by running **singularity -h**

<details>

<summary>cent7a(SLAC)$ singularity -h</summary>
<blockquote><pre>
Linux container platform optimized for High Performance Computing (HPC) and
Enterprise Performance Computing (EPC)

Usage:
  singularity [global options...]

Description:
  Singularity containers provide an application virtualization layer enabling
  mobility of compute via both application and environment portability. With
  Singularity one is capable of building a root file system that runs on any 
  other Linux system where Singularity is installed.

Options:
  -d, --debug     print debugging information (highest verbosity)
  -h, --help      help for singularity
      --nocolor   print without color output (default False)
  -q, --quiet     suppress normal output
  -s, --silent    only print errors
  -v, --verbose   print additional information
      --version   version for singularity

Available Commands:
  build       Build a Singularity image
  cache       Manage the local cache
  capability  Manage Linux capabilities for users and groups
  config      Manage various singularity configuration (root user only)
  delete      Deletes requested image from the library
  exec        Run a command within a container
  help        Help about any command
  inspect     Show metadata for an image
  instance    Manage containers running as services
  key         Manage OpenPGP keys
  oci         Manage OCI containers
  plugin      Manage Singularity plugins
  pull        Pull an image from a URI
  push        Upload image to the provided URI
  remote      Manage singularity remote endpoints
  run         Run the user-defined default command within a container
  run-help    Show the user-defined help for an image
  search      Search a Container Library for images
  shell       Run a shell within a container
  sif         siftool is a program for Singularity Image Format (SIF) file manipulation
  sign        Attach a cryptographic signature to an image
  test        Run the user-defined tests within a container
  verify      Verify cryptographic signatures attached to an image
  version     Show the version for Singularity

Examples:
  $ singularity help <command> [<subcommand>]
  $ singularity help build
  $ singularity help instance start


For additional help or support, please visit https://www.sylabs.io/docs/
</pre></blockquote>
</details>


<details>

<summary>spar0101(BNL)$ singularity -h</summary>
<blockquote><pre>
USAGE: singularity [global options...] <command> [command options...] ...

     GLOBAL OPTIONS:
       -d|--debug    Print debugging information
       -h|--help     Display usage summary
       -s|--silent   Only print errors
       -q|--quiet    Suppress all normal output
          --version  Show application version
       -v|--verbose  Increase verbosity +1
       -x|--sh-debug Print shell wrapper debugging information

GENERAL COMMANDS:
  help       Show additional help for a command or container
  selftest   Run some self tests for singularity install

CONTAINER USAGE COMMANDS:
  exec        Execute a command within container
  run         Launch a runscript within container
  shell       Run a Bourne shell within container
  test        Launch a testscript within container

CONTAINER MANAGEMENT COMMANDS:
  apps        List available apps within a container
  bootstrap   *Deprecated* use build instead
  build       Build a new Singularity container
  check       Perform container lint checks
  inspect     Display container's metadata
  mount       Mount a Singularity container image
  pull        Pull a Singularity/Docker container to $PWD

COMMAND GROUPS:
  image      Container image command group
  instance   Persistent instance command group

CONTAINER USAGE OPTIONS:
   see singularity help <command>

For any additional help or support visit the Singularity
website: https://www.sylabs.io/
</pre></blockquote>
</details>

The most frequently used commands are: **run**, **exec**, **shell** and
**pull**.

For additional help or support, please visit
<https://www.sylabs.io/docs/>. For quick start of version-3.5, you can
refer to [the User
Guide](https://sylabs.io/guides/3.5/user-guide/quick_start.html#).

## <span id="Cache_Folders"></span> Cache Folders

To make downloading images for build and pull faster and less redundant,
Singularity uses a caching strategy. By default, Singularity will create
a set of **cache folders** in your **$HOME** directory for docker
layers, Cloud library images, and metadata, respectively:

  - $HOME/.singularity/cache/library
  - $HOME/.singularity/cache/oci
  - $HOME/.singularity/cache/oci-tmp

which could take quite much space, depending the image size.

You can set the envvar **SINGULARITY\_CACHEDIR** to use other directory
than the default cache directory **$HOME/.singularity/cache**.

## <span id="Binding_Paths_and_Mounts"></span> Binding Paths and Mounts

On default, Singularity will map the following directories on your host
system to directories within the container:

  - $HOME
  - $PWD
  - /tmp
  - /proc
  - /sys
  - /dev

You can bind additional directories with option **-B | --bind**, such
as:

  - `-B /data`: map /data on the host to /data on the container
  - or `-B /usr/local/share:/share,/data` (please note the **comma
    delimiter**) : map /usr/local/share on the host to /share on the
    container, and map /data on the host to /data on the container.

You can also defined envvar **SINGULARITY\_BINDPATH** (such as `export
SINGULARITY_BINDPATH="/data:/mnt"`) to bind paths.

## <span id="Examples"></span> Examples

You need define the envvar **SINGULARITY\_CACHEDIR** to a directory to
have enough space to accommodate the Singularity cache.

### <span id="Some_Fun_Exercise_Examples"></span> Some Fun Exercise Examples

There are some fun exercises to play with the singularity command. One
simple example is "Hello World", which takes the container image from
[the Singularity container
hub](https://singularity-hub.org/).

> 
> 
>     lxplus$ singularity run shub://vsoch/hello-world
>     INFO:    Downloading shub image
>      59.75 MiB / 59.75 MiB [================================] 100.00% 35.87 MiB/s 1s
>     INFO:    Convert SIF file to sandbox...
>     RaawwWWWWWRRRR!! Avocado!
>     INFO:    Cleaning up image...

Let us try another example of "cow say":

> 
> 
>     lxplus$ singularity run shub://GodloveD/lolcow
>     INFO:    Downloading shub image
>      87.57 MiB / 87.57 MiB [================================] 100.00% 49.57 MiB/s 1s
>     INFO:    Convert SIF file to sandbox...
>      _______________________________
>     < Keep it short for pithy sake. >
>      -------------------------------
>             \   ^__^
>              \  (oo)\_______
>                 (__)\       )\/\
>                     ||----w |
>                     ||     ||
>     INFO:    Cleaning up image...

The similar container image is also available on [the Docker Image
Hub](https://hub.docker.com/).

> 
> 
>     lxplus$ singularity run docker://godlovedc/lolcow
>     INFO:    Converting OCI blobs to SIF format
>     INFO:    Starting build...
>     Getting image source signatures
>     Copying blob 9fb6c798fa41 done
>     Copying blob 3b61febd4aef done
>     Copying blob 9d99b9777eb0 done
>     Copying blob d010c8cf75d7 done
>     Copying blob 7fac07fb303e done
>     Copying blob 8e860504ff1e done
>     Copying config 73d5b1025f done
>     Writing manifest to image destination
>     Storing signatures
>     2020/03/30 16:30:38  info unpack layer: sha256:9fb6c798fa41e509b58bccc5c29654c3ff4648b608f5daa67c1aab6a7d02c118
>     2020/03/30 16:30:41  info unpack layer: sha256:3b61febd4aefe982e0cb9c696d415137384d1a01052b50a85aae46439e15e49a
>     2020/03/30 16:30:41  info unpack layer: sha256:9d99b9777eb02b8943c0e72d7a7baec5c782f8fd976825c9d3fb48b3101aacc2
>     2020/03/30 16:30:41  info unpack layer: sha256:d010c8cf75d7eb5d2504d5ffa0d19696e8d745a457dd8d28ec6dd41d3763617e
>     2020/03/30 16:30:41  info unpack layer: sha256:7fac07fb303e0589b9c23e6f49d5dc1ff9d6f3c8c88cabe768b430bdb47f03a9
>     2020/03/30 16:30:41  info unpack layer: sha256:8e860504ff1ee5dc7953672d128ce1e4aa4d8e3716eb39fe710b849c64b20945
>     INFO:    Creating SIF file...
>     INFO:    Convert SIF file to sandbox...
>      ________________________________________
>     / Q: What do you call the scratches that \
>     | you get when a female                  |
>     |                                        |
>     \ sheep bites you? A: Ewe nicks.         /
>      ----------------------------------------
>             \   ^__^
>              \  (oo)\_______
>                 (__)\       )\/\
>                     ||----w |
>                     ||     ||
>     INFO:    Cleaning up image...

As you see, singularity need download and convert the docker image into
a singularity image file (sif) first.

Singularity version 3 also supports container images on [the Singularity
container
library](https://cloud.sylabs.io/library),
which is not supported in Singularity version 2. Let us check what is
the latest in the Ubuntu container on the library:

> 
> 
>     lxplus$ singularity -q exec library://ubuntu cat /etc/os-release
>     NAME="Ubuntu"
>     VERSION="18.10 (Cosmic Cuttlefish)"
>     ID=ubuntu
>     ID_LIKE=debian
>     PRETTY_NAME="Ubuntu Cosmic Cuttlefish (development branch)"
>     VERSION_ID="18.10"
>     HOME_URL="https://www.ubuntu.com/"
>     SUPPORT_URL="https://help.ubuntu.com/"
>     BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
>     PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
>     VERSION_CODENAME=cosmic
>     UBUNTU_CODENAME=cosmic

### <span id="Using_Containers_for_LaTeX"></span> Using Containers for LaTeX

If you need LaTeX and do not have LaTeX installed locally, you can use
LaTeX container images.

Let us pull the image and convert into sif first, and use the converted
image locally:

> 
> 
>     lxplus$ singularity pull latex.sif docker://dockershelf/latex
>     lxplus$ singularity shell latex.sif
>     INFO:    Convert SIF file to sandbox...
>     Singularity> pdflatex --version
>     pdfTeX 3.14159265-2.6-1.40.20 (TeX Live 2019/Debian)
>     kpathsea version 6.3.1
>     Copyright 2019 Han The Thanh (pdfTeX) et al.
>     There is NO warranty.  Redistribution of this software is
>     covered by the terms of both the pdfTeX copyright and
>     the Lesser GNU General Public License.
>     For more information about these matters, see the file
>     named COPYING and the pdfTeX source.
>     Primary author of pdfTeX: Han The Thanh (pdfTeX) et al.
>     Compiled with libpng 1.6.37; using libpng 1.6.37
>     Compiled with zlib 1.2.11; using zlib 1.2.11
>     Compiled with xpdf version 4.01
>     .

There is another older PDFLaTex on the docker image hub, but with much
more packages installed.

> 
> 
>     lxplus$ singularity pull pdflatex.sif docker://astrotrop/pdflatex
>     lxplus$ singularity shell pdflatex.sif
>     INFO:    Convert SIF file to sandbox...
>     Singularity> pdflatex --version
>     pdfTeX 3.14159265-2.6-1.40.15 (TeX Live 2014)
>     kpathsea version 6.2.0
>     Copyright 2014 Peter Breitenlohner (eTeX)/Han The Thanh (pdfTeX).
>     There is NO warranty.  Redistribution of this software is
>     covered by the terms of both the pdfTeX copyright and
>     the Lesser GNU General Public License.
>     For more information about these matters, see the file
>     named COPYING and the pdfTeX source.
>     Primary author of pdfTeX: Peter Breitenlohner (eTeX)/Han The Thanh (pdfTeX).
>     Compiled with libpng 1.6.10; using libpng 1.6.10
>     Compiled with zlib 1.2.8; using zlib 1.2.8
>     Compiled with poppler version 0.26.2

Then you can process your tex file inside the container.

### <span id="Using_Containers_for_Machine_Lea"></span> Using Containers for Machine Learning

There are many containers available for machine learning.

For example, you can use sklearn containers.

> 
> 
> ``` 
> lxplus$  singularity pull sklearn.sif docker://fastgenomics/sklearn:0.19.1-p36-v5
> lxplus$  singularity shell sklearn.sif
> Singularity> python3
> >>> import sklearn  
> >>> import pandas   
> >>> import numpy    
> >>> import scipy    
> ```

Atlas also provides machine learning containers on CVMFS:

> 
> 
>     lxplus$ ls /cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlasml
>     
>     atlasml-base:latest    ml-base:centos           ml-base:py-3.6.8
>     atlasml-base:py-3.6.8  ml-base:centos-py-3.6.8  ml-base:py-3.7.2
>     atlasml-base:py-3.7.2  ml-base:centos-py-3.7.2
>     ml-base:bionic         ml-base:latest
>     singularity shell /cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlasml/atlasml-base:py-3.7.2
>     Singularity> python3
>     >>> import sklearn
>     >>> import torch

As the container path
`/cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlasml/` indicates,
the above container is also available on the docker hub via
**docker://**. But it would take quite a while (about an hour) to pull
the container from the docker hub and convert into a singularity image
file (sif).

## <span id="Using_Containers_through_ARLB"></span> Using Containers through ARLB

Prior to use ATLAS\_LOCAL\_ROOT\_BASE (ALRB), you need install CVMFS
first. Please refer to [the CernVM-FS Client Quick
Start](https://cernvm.cern.ch/portal/filesystem/quickstart)
at CERN for CVMFS installation guide.

Then define the command **setupATLAS** as follows:

    export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
    alias setupATLAS='source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh'

The option **-c** in the command **setupATLAS** takes container location
or container keyword such as **slc5**, **slc6**, **centos6**, or
**centos7**. Please check [ALRB
Containers](https://twiki.atlas-canada.ca/bin/view/AtlasCanada/Containers)
for more details.

For example, start a centos7 container with ALRB setup:

> 
> 
>     lxplus$ setupATLAS  -c centos7
>     ------------------------------------------------------------------------------
>     Singularity: 3.5.3
>     From: /usr/bin/singularity
>     ContainerType: atlas-default
>     singularity  exec  -e  -H /afs/cern.ch/user/y/yesw/.alrb/container/singularity/home.snlmtE:/alrb -B /cvmfs:/cvmfs -B /afs/cern.ch/user/y:/home -B /tmp/yesw:/srv /cvmfs/atlas.cern.ch/repo/containers/fs/singularity/x86_64-centos7 /bin/bash
>     ------------------------------------------------------------------------------
>     lsetup               lsetup <tool1> [ <tool2> ...] (see lsetup -h):
>      lsetup agis          ATLAS Grid Information System
>      lsetup asetup        (or asetup) to setup an Athena release
>      lsetup atlantis      Atlantis: event display
>      lsetup eiclient      Event Index 
>      lsetup emi           EMI: grid middleware user interface 
>      lsetup ganga         Ganga: job definition and management client
>      lsetup lcgenv        lcgenv: setup tools from cvmfs SFT repository
>      lsetup panda         Panda: Production ANd Distributed Analysis
>      lsetup pod           Proof-on-Demand (obsolete)
>      lsetup pyami         pyAMI: ATLAS Metadata Interface python client
>      lsetup root          ROOT data processing framework
>      lsetup rucio         distributed data management system client
>      lsetup views         Set up a full LCG release
>      lsetup xcache        XRootD local proxy cache
>      lsetup xrootd        XRootD data access
>     advancedTools        advanced tools menu
>     diagnostics          diagnostic tools menu
>     helpMe               more help
>     printMenu            show this menu
>     showVersions         show versions of installed software
>     
>     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
>     You are running on a RHEL7 compatible OS.
>     Please refer to these pages for the status and open issues:
>      For releases:
>       https://twiki.cern.ch/twiki/bin/view/AtlasComputing/CentOS7Readiness#ATLAS_software_status
>     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
>     
>     
>     Singularity> 

If you do not need either ALRB or CVMFS, then run with tag **+noalrb**
and **+nocvmfs** after the image location/keyword:

> 
> 
>     lxplus$ setupATLAS  -c centos7+noalrb+nocvmfs
>     ------------------------------------------------------------------------------
>     Singularity: 3.5.3
>     From: /usr/bin/singularity
>     ContainerType: atlas-default
>     singularity  exec  -e  -H /afs/cern.ch/user/y/yesw/.alrb/container/singularity/home.tbnhXz:/alrb -B /afs/cern.ch/user/y:/home -B /tmp/yesw:/srv /cvmfs/atlas.cern.ch/repo/containers/fs/singularity/x86_64-centos7 /bin/bash
>     ------------------------------------------------------------------------------
>     Singularity> 

If you like to start a Ubuntu OS without ALRB but with CVMFS, then run
with tag **+noalrb** after the mage location/keyword:

> 
> 
>     lxplus$ setupATLAS -c library://ubuntu+noalrb
>     INFO:    Convert SIF file to sandbox...
>     INFO:    Cleaning up image...
>     ------------------------------------------------------------------------------
>     Singularity: 3.5.3
>     From: /usr/bin/singularity
>     ContainerType: non-atlas
>     singularity  exec  -e  -H /afs/cern.ch/user/y/yesw/.alrb/container/singularity/home.Ion4ZS:/alrb -B /cvmfs:/cvmfs -B /afs/cern.ch/user/y:/home -B /tmp/yesw:/srv library://ubuntu /bin/bash
>     ------------------------------------------------------------------------------
>     INFO:    Convert SIF file to sandbox...
>      setupATLAS is available.
>               
>     Singularity>

# <span id="Explore_Container_Images"></span> Explore Container Images

## <span id="Containers_on_CVMFS"></span> Containers on CVMFS

There are a few singularity containers accessible by keyword **slc5**,
**slc6**, **centos6** and **centos7** through command `setupATLAS -c`.
There are many other images available under
**/cvmfs/unpacked.cern.ch/**. If this CVMFS path is not visible, please
add this mount point to the CVMFS client on your computer.

> 
> 
>     lxplus$ ls /cvmfs/unpacked.cern.ch/
>     gitlab-registry.cern.ch  logDir  registry.hub.docker.com
>     
>     lxplus$ ls /cvmfs/unpacked.cern.ch/registry.hub.docker.com/
>     atlas        atlasml   cmssw      jodafons  lofaruser      siscia
>     atlasadc     atlrpv1l  danikam    kratsg    lukasheinrich  stfc
>     atlasamglab  clelange  engineren  library   pyhf           sweber613
>     
>     lxplus$ ls /cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlasml
>     atlasml-base:latest    ml-base:centos           ml-base:py-3.6.8
>     atlasml-base:py-3.6.8  ml-base:centos-py-3.6.8  ml-base:py-3.7.2
>     atlasml-base:py-3.7.2  ml-base:centos-py-3.7.2

The containers under
`/cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlasml/` are for
machine learning. For Atlas release containers, they are under
`/cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlas/`

> 
> 
>     lxplus$ ls /cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlas
>     analysisbase:21.2.10            athanalysis:21.2.102
>     analysisbase:21.2.100           athanalysis:21.2.10-20171115
>     [...]
>     analysisbase:21.2.16            athanalysis:21.2.19
>     analysisbase:21.2.16-20180129   athanalysis:21.2.19-20180221
>     analysisbase:21.2.17            athena:21.0.15
>     analysisbase:21.2.17-20180206   athena:21.0.15_100.0.2
>     analysisbase:21.2.18            athena:21.0.15_31.8.1
>     analysisbase:21.2.18-20180213   athena:21.0.15_DBRelease-100.0.2_Patched
>     analysisbase:21.2.19            athena:21.0.23
>     analysisbase:21.2.19-20180221   athena:21.0.23_DBRelease-200.0.1
>     analysisbase:21.2.60            athena:21.0.31
>     analysisbase:21.2.88            athena:21.0.31_100.0.2
>     athanalysis:21.2.10             athena:21.0.31_31.8.1
>     athanalysis:21.2.100            athena:22.0.5_2019-09-24T2128_100.0.2
>     athanalysis:21.2.100-20191127   athena:22.0.6_2019-10-04T2129
>     athanalysis:21.2.101            athena:22.0.9
>     athanalysis:21.2.101-20191208

Let us take an example of release AthAnalysis,2.2.115 under
`/cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlas/`

> 
> 
>     lxplus$ singularity exec -c /cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlas/athanalysis:21.2.115/release_setup.sh bash
>     singularity exec -c /cvmfs/unpacked.cern.ch/registry.hub.docker.com/atlas/athanalysis:21.2.115 bash
>     Singularity> ls /home/atlas
>     release_setup.sh
>     Singularity> source /home/atlas/release_setup.sh
>     Configured GCC from: /opt/lcg/gcc/8.3.0-cebb0/x86_64-centos7/bin/gcc
>     Taking LCG releases from: /opt/lcg
>     Taking Gaudi from: /usr/GAUDI/21.2.115/InstallArea/x86_64-centos7-gcc8-opt
>     Configured AthAnalysis from: /usr/AthAnalysis/21.2.115/InstallArea/x86_64-centos7-gcc8-opt
>     [bash][yesw AthAnalysis-21.2.115]:~ >

That is, start the wanted container, then source
/home/atlas/release\_setup.sh.

## <span id="Containers_on_Docker_Hub"></span> Containers on Docker Hub

The Docker hub hosts the largest container images. You can input keyword
to [search on the
hub](https://hub.docker.com/search/?q=rust&type=image).
For example, you can put a keyword "atlas/" under the search field as
shown below:

  - A screenshot of searching for "Atlas/" on the Docker Hub:  
    ![](./DockerHub-Atlas.jpg)

Click on the found container, it will provides the pull command
instruction and sometimes also a brief description.

## <span id="Containers_on_Singularity_Hub_an"></span> Containers on Singularity Hub and Library

There are many container images on the Singularity Hub and Library.

  - Singularity Hub: <https://singularity-hub.org/>. Click "Collections"
    on the top menu to search by **Label**, **Tag** or **App** name.
  - Singularity Library: <https://cloud.sylabs.io/library>. It is not
    supported in Singularity version 2. Put keyword in the search field
    on the very top to search for your wanted container.

# <span id="Contained_based_Jobs_on_the_Grid"></span> Contained-based Jobs on the Grid

There are more resources available on the grid, you can run
container-based jobs on the grid. Both prun and pathena provide an
option **--containerImage** to allow jobs to run inside a specified
container on the grid. Check the following page for more details:

<https://twiki.cern.ch/twiki/bin/view/PanDA/PandaRun#Run_user_containers_jobs>

You can also run **prun --helpGroup=containerJob** for more
container-related options.

Please note that you should test your job interactively first as
documented above, prior to submitting them to the grid.

