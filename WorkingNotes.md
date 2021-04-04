## What is this repo
This repo helps to bring contents of the other repo, tier3docs to readthedocs.io (RTD).
In order NOT to change the layout of the tier3docs repo to fix the need of RTS, we create
this repo with the following:

1. .readthedocs.yml
2. mkdocs.yml   (This file contains the structure of the left navegation panel)
3. requirements.txt
3. tier3docs/ (the acutual doc directory)  

## Limit mkdocs.yml navegation panel to two levels
It seems standalone mkdocs can support >2 nested levels in navegation panel. But at the 
readthedocs.io, only up to 2 levels are supported.

## How to check my edited doc before commit to git?
1. `python3 -m pip install mkdocs`
2. cd to the root directory of the github repo
3. `mkdocs serve`

This will start a web server at http://127.0.0.1:8000. Point your web broswer to it.

After the change is commit to git, readthedocs.io will automatically detect the change and 
rebuild the doc at https://usatlas.readthedocs.io/projects/af-docs
