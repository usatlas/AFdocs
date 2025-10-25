# Available Storage

On the storage side, S3DF provides:

1. **Several Weka parallel POSIX file systems** for user home and data. At the
   backend — invisible and transparent to users — each of these storage systems
   consists of an NVMe cache of a few PB, and a spinning-disk-backed Ceph S3
   object storage. All the file system metadata reside in the NVMe cache.
2. **A Lustre file system** that was previously used by the SDF system (S3DF's
   predecessor).
3. **GPFS and AFS** from the older facilities, mounted read-only on a few
   interactive login nodes to facilitate data migration.
4. **CVMFS**, available on all interactive and batch nodes.

## Space Available to ATLAS Users

The following spaces are available to ATLAS users:

1. **`$HOME`** — quota **25 GB** on Weka file system.
2. **`/sdf/data/atlas/u/<username>`** — quota **200 GB** on Weka file system.
3. **`/sdf/scratch/users/<username_initial>/<username>`** — quota **100 GB** on
   Weka file system. This is a scratch space; data are subject to purge when the
   total scratch space is full.
4. **`/fs/ddn/sdf/group/atlas/d/<username>`** — please create your own
   directory. This is a **Lustre** file system (also available in the old SDF
   facility at `/sdf/group/atlas/d`). It is fast for bulk data access but not
   suitable for software. There is currently no easy way to enforce quota on
   this file system. Please try to keep your usage under **2 TB** if possible.
5. **`/sdf/group/atlas`** — quota **10 TB** on Weka file system, shared by all
   users. This space is intended for storing **software**, not data. _(Note:
   this is a new space at S3DF. It is unrelated to the SDF space
   `/sdf/group/atlas`.)_
6. **`/sdf/scratch/atlas`** — **5 TB** shared scratch space, subject to purge.
7. **`/lscratch`** on batch nodes — **300 GB – 7 TB**, depending on the node.

---

For existing users, note that the old **AFS** and **GPFS** spaces are no longer
available at S3DF (except read-only on a few interactive nodes). AFS and GPFS
will soon be decommissioned at SLAC. Please move your data from AFS and GPFS to
the spaces listed above.

The best tools to copy your data from AFS/GPFS to S3DF spaces are:

- the Unix command:

  ```bash
  cp -r -p source destination
  ```

- or `rsync`, which is also easy to use.

Copying data may take days, so you may want to run your `cp` or `rsync` inside a
`screen` session.
