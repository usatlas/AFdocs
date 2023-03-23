## <span id="xcache_uchicago"></span> Xcache at UChicago

UChicago Analysis Facility maintains an XCache server (managed through SLATE), with 25 x 1.5 TB NVMes and 2x25 Gbps NIC.

ServiceX uses the XCache by default.

Users that want do access remote data of their own (on EOS or elsewhere) can manually add the prefix root://192.170.240.18:1094// to their root paths, eg:

If the original path is eg.:

    root://someserver.org:1094//atlaslocalgroupdisk/rucio/user/mgeyik/63/c4/user.mgeyik.26617246._000006.out.root

make it:

    root://192.170.240.18:1094//root://someserver.org:1094//atlaslocalgroupdisk/rucio/user/mgeyik/63/c4/user.mgeyik.26617246._000006.out.root
