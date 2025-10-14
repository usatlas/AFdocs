## What is this repo

This repo helps to bring contents of the other repo, tier3docs to readthedocs.io
(RTD). In order NOT to change the layout of the tier3docs repo to fix the need
of RTS, we create this repo with the following:

1. .readthedocs.yml
2. mkdocs.yml (This file contains the structure of the left navegation panel)
3. requirements.txt
4. tier3docs/ (the actual doc directory)

## Limit mkdocs.yml navegation panel to two levels

It seems standalone mkdocs can support >2 nested levels in navegation panel. But
at the readthedocs.io, only up to 2 levels are supported.

## How to check my edited doc before commit to git?

After editing the docs, use the following steps to start a web server at
http://127.0.0.1:8000. Then point your web browser to this local web server to
check the changes you just made.

1. `python3 -m pip install mkdocs mkdocs-include-markdown-plugin`
2. cd to the root directory of the github repo
3. `mkdocs serve`

After new changes are commit to git, readthedocs.io will automatically detect
the changes and rebuild the docs at
https://usatlas.readthedocs.io/projects/af-docs
