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
