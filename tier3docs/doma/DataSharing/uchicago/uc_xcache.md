## <span id="uc_xcache"></span> Xcache at UChicago

UChicago Analysis Facility maintains an XCache server (managed through SLATE), with 25 x 1.5 TB NVMes and 2x25 Gbps NIC.

ServiceX uses the XCache by default.

Users that want do access remote data of their own on EOS or elsewhere, can manually add the prefix `root://192.170.240.18:1094//` to their root paths and the prefix `:1094` to ther server address, eg:

If the original path is eg.:
```bash
root://someserver.org//atlaslocalgroupdisk/rucio/user/mgeyik/63/c4/user.mgeyik.26617246._000006.out.root
```
then make it:
```bash
root://192.170.240.18:1094//root://someserver.org:1094//atlaslocalgroupdisk/rucio/user/mgeyik/63/c4/user.mgeyik.26617246._000006.out.root
```

Example:

```bash
# Original path
root://eosatlas.cern.ch//eos/atlas/atlastier0/rucio/data_13TeV/physics1/data_13TeV.004345.physics_Main.eaq./data_13TeV.004345.physics_Main.eaq_0001.root’
# make it:
root://192.170.240.18:1094//root://eosatlas.cern.ch:1094//eos/atlas/atlastier0/rucio/data_13TeV/physics1/data_13TeV.004345.physics_Main.eaq./data_13TeV.004345.physics_Main.eaq_0001.root
```
 
