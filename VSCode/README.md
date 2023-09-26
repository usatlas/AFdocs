Using VSCode
============

# Introduction

[Visual Studio Code](https://code.visualstudio.com/) is a lightweight but powerful source code editor which runs on your desktop.
It provides a rich code editing experience with features like 
- syntax highlighting,
- auto-indentation,
- intelliSense (context-aware suggestions as you type),
- linting for various programming languages,
- powerful debugging
- Integrated Terminal

You can enhance its functionality by installing extensions from [the Visual Studio Code Marketplace](https://marketplace.visualstudio.com/VSCode).

# Remote-Tunnels

The Visual Studio Code [Remote - Tunnels](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-server) extension lets you 
connect to a remote machine, like a desktop PC or virtual machine (VM), via a secure tunnel.

You can connect to that machine from a VS Code client anywhere, **without** the requirement of **SSH**.

This can eliminate the need for source code to be on your VS Code client machine since the **extension runs commands** 
and other extensions directly **on the remote machine**.

VS Code can provide a **local-quality development experience** - including full IntelliSense (completions), code navigation, 
and debugging - **regardless of where your code is hosted**.

## Setup Guide

Requirements to run remote-tunnels:
- A GitHub account
- VSCode client and extension *Remote-Tunnels* on the local machine
- [VSCode CLI](https://code.visualstudio.com/docs/editor/command-line) on the remote machine

### Step-1: Create a Secure Tunnel on the Remote Machine

You can grab the CLI through a [standalone install](https://code.visualstudio.com/#alt-downloads). 
However, the executable `code` has already been installed as */cvmfs/atlas.sdcc.bnl.gov/users/yesw/t3s/bin/code*.

Create a secure tunnel with the tunnel command:
```
code tunnel
```

It would print out something like:
> \*  
> \* Visual Studio Code Server  
> \*  
> \* By using the software, you agree to   
> \* the Visual Studio Code Server License Terms (https://aka.ms/vscode-server-license) and  
> \* the Microsoft Privacy Statement (https://privacy.microsoft.com/en-US/privacystatement).  
> \*  
> To grant access to the server, please log into https://github.com/login/device and use code B45E-B1C0  
>

On a browser, following the above instruction, visit https://github.com/login/device, input the code.
On the next web page, click on the button of **Authorize Visual-Studio-Code**.

Afterward, the remote machine screen would print out a new line:
> **What would you like to call this machine?**

Provide a name to the remote machine, says, *BNL-SPAR*.

Then it would yield something like:
> [2023-09-25 22:22:51] info Creating tunnel with the name: bnl-spar
> 
> Open this link in your browser https://vscode.dev/tunnel/bnl-spar/home/tmp/yesw

Now you can explore the files on the remote machine, and use VSCode to edit file:
- Either on a browser, open the above link: https://vscode.dev/tunnel/bnl-spar/home/tmp/yesw
- Or in VSCode client, open **Remote Explorer**, click on **Remotes**, then **Tunnels**, choose the name **BNL-SPAR**.

Upon opening a folder/file, you just click on the button of **Yes, I trusted the authors**.
