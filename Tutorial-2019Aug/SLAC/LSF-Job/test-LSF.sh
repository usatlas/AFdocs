# write both stdout and stderr into one log file
log=$PWD/myjob.log
exec &>$log

inputFile=root://atlrdr1//xrootd/atlas/atlaslocalgroupdisk/rucio/data16_13TeV/7f/94/DAOD_SUSY15.11525262._000021.pool.root.1

../bin/Exam_JetsPlot $inputFile
