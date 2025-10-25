## Available Storage

On the storage side, S3DF provides

<ol>
  <li> Several  Weka parallel Posix file systems for user home and data. At the backend and ,
invisible and transparent to the users, each of these storage system consists of a NVMe cache of a few PB,
and a spinning disk backed CEPH s3 object storage. All the file system metadata reside in the NVMe cache.
  <li> The S3DF also mounted a Lustre file system that was previously used by the SDF system (S3DF's predecesssor).
  <li> GPFS and AFS from the older faclities are mounted read-only on a few interactive login nodes to facilitate
data migration
  <li> CVMFS is available on all interactive and batch nodes.
</ol>

### Space available to the ATLAS users

The following spaces are available to ATLAS users:

<ol>
  <li> $HOME: quota 25GB on Weka file system
  <li> /sdf/data/atlas/u/&lt;username>: quota 200GB on Weka file system
  <li> /sdf/scratch/users/&lt;username_intial>/&lt;username>: quota 100GB on Weka file system. This is a scratch space. Data
are subject to purge when the total scratch space is full.
  <li> /fs/ddn/sdf/group/atlas/d/&lt;username>: create your own dir please. This is a Lustre file system (it is also
available in the old SDF facility at /sdf/group/atlas/d). It is fast
for bulk data access, but is not suitable for software. There is currently no easy way to enforce quota on this
file system. Please try to keep your usage under 2TB if possible <p>
  <li> /sdf/group/atlas: quota 10TB on Weka file system shared by all users, for groups to storage software but not data.
(Note that this is a new space at S3DF. It has nothing to do with the above SDF space /sdf/group/atlas)
  <li> /sdf/scratch/atlas: 5TB shared scratch space, subject to purge.
  <li> /lscratch on batch nodes, 300GB-7TB (depend on nodes).
</ol>

For existing users, you may notice that the old AFS and GPFS spaces are no
longer availalb at S3DF (except read-only on a few interactive nodes). AFS and
GPFS will be decommissioned soon at SLAC. Please move your data in AFS and GPFS
space to the above spaces.

The best tool to copy your data from AFS/GPFS to S3DF spaces is probably the
unix `cp -r -p` command. `rsync` is also a good and easy to use tool. Copying
data may take days. So you may want to run your `cp` or `rsync` inside a
`screen` session.
