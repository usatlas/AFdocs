## What is this repo
This repo helps to bring contents of the other repo, tier3docs to readthedocs.io (RTD).
In order NOT to change the layout of the tier3docs repo to fix the need of RTS, we create
this repo with the following:

1. .readthedocs.yml
2. mkdocs.yml
3. requirements.txt
3. tier3docs/ (from the tier2doc repo, as a git submodule of this repo)  

## Limit mkdocs.yml navegation panel to two levels
It seems standalone mkdocs can support >2 nested levels in navegation panel. But at the 
readthedocs.io, only up to 2 levels are supported.

## What to do after a submodule is updated
Use tier3docs (a git submodule of this repo) as example: If tier3docs is updated outside 
of the AFdocs (the repo), do the following:

1. git clone git@github.com:usatlas/AFdocs
2. cd AFdocs
3. git submodule sync
4. git submodule update --init --force --recursive tier3docs
5. cd tier3docs
6. git checkout master
7. git pull
8. cd ..
9. git commit -m "tier3docs is updated" tier3docs
10. git push

The last step will trigger ReadTheDocs to rebuild https://usatlas.readthedocs.io/projects/af-docs.
If this page is already openned in the web browser, try refreshing browser cache (usually by pressing 
shift while reload)

## Update the tier3docs repo outside of the repo tree!!!
Above we checked out the tier3docs. Please please don't try to edit anything there and expect to be
able to git push to tier3docs. This is because the we used 
```
git submodule add https://github.com/usatlas/tier3docs
```
Note the https://... URL. Once git enforced two-factor authentication, git push the this https URL with
username and password may not work.
