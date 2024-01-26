# Ways to Implement ML Containers

The ML containers were developed to be used both at the command line and with each of the AF's jupyter interfaces.

## Command Line ML Container Usage

The images are deployed onto the Docker hub and CVMFS and there are 3 ways to run the ML images at the command line.

??? note "**Singularity**"

    You can directly use **Singularity** to develop with the containers using the `singularity run` command.

    ``` output
    lxplus901% singularity run /cvmfs/unpacked.cern.ch/registry.hub.docker.com/yesw2000/ml-base:centos7-python38
    For the content in this container,
      please read the file /list-of-pkgs-inside.txt

    To create your own new env, run "source /create-newEnv-on-base.sh -h" for help
    Singularity> python --version
    Python 3.8.17
    Singularity>
    ```

??? note "**Virtual Environment**"

    We have included a bash script with every container that will create a virtual environment based on that container. 

    ``` output
    lxplus901% source /cvmfs/unpacked.cern.ch/registry.hub.docker.com/yesw2000/ml-base:centos7-python38/setupMe-on-host.sh
    (base) lxplus901% python --version
    Python 3.8.17
    (base) lxplus901%
    ```

??? note "**Docker or podman**"

    Since the containers are also deployed to Docker hub, you can use `docker` or `podman` to develop with them.

    ``` output
    lxplus901% podman run -it docker.io/yesw2000/ml-base:centos7-python38
    ERRO[0000] cannot find UID/GID for user yesw: no subuid ranges found for user "yesw" in /etc/subuid - check rootless mode in man pages.
    WARN[0000] Using rootless single mapping into the namespace. This might break some images. Check /etc/subuid and /etc/subgid for adding sub*ids if not using a network user
    Trying to pull docker.io/yesw2000/ml-base:centos7-python38...
    Getting image source signatures
    Copying blob 7a7bfb37ab80 done  
    Copying blob 777139c0ccd6 done  
    Copying blob 11acc4d123ae done  
    Copying blob 845f8ce3e594 done  
    Copying blob 1b828031002a done  
    Copying blob 3f3f4dff06ec done  
    Copying blob 743e1b9fe53f done  
    Copying blob a5fd80583b08 done  
    Copying blob 34393f5f9fd4 done  
    Copying blob ef9d4f56bd36 done  
    Copying blob 42242a0ba1e5 done  
    Copying blob 7a2b6c54e081 done  
    Copying blob acb70224b2a8 done  
    Copying blob b0f8d0afc04a done  
    Copying blob 708671683597 done  
    Copying blob 679007b0c85b done  
    Copying blob 7a8b17a36c6d done  
    Copying config 7386b26131 done  
    Writing manifest to image destination
    Storing signatures
    (base) bash-4.2# python --version
    Python 3.8.17
    (base) bash-4.2#
    ```	

## Jupyter Interface at AFs

??? note "**Brookhaven**"

    Use the following steps to implement the ML container through the BNL jupyter interface:

    1. Open the BNL Jupyter Interface and create a new notebook
    2. For **Select JupyterLab Environment** select *Default*
    3. Select *Custom* in the **Singularity Container** question and input the `/cvmfs` address for ML container
    4. Press Start!

    After pressing start, the server for the notebook will begin the setup process. After a minute or so, your jupyter notebook will appear and you will have a number of kernels available to use. The kernel associated with the container is called `ML-Python3`.


??? note "**UChicago**"

    Currently the UChicago JupyterLab servers don't allow custom containers when creating a new notebook. This is planning on being updated soon. In the meantime, the `ml-platform:latest` container shown in the `Image` dropdown box does have all packages necessary for running the ML Tutorial material.


??? note "**SLAC**"

    Steps for using ML containers using SLAC Jupyter interface:

    1. Connect to SLAC's [S3DF Jupyter Portal](https://s3df.slac.stanford.edu/pun/sys/dashboard/batch_connect/sys/slac-ood-jupyter/session_contexts/new)
    2. After you login, you'll come to the menu where you can define your jupyter server. The first dropdown is the **Jupyter Instance**. Choose the "Custom Singularity Container" option.
    3. Now the **Commands to initiate Jupyter** box will be editable. Replace the content of the box by the following:
    ```
    export APPTAINER_IMAGE_PATH=/cvmfs/unpacked.cern.ch/registry.hub.docker.com/yesw2000/ml-base:centos7-python38
    function jupyter() { apptainer exec --nv -B /cvmfs,/sdf,/fs,/sdf/scratch,/lscratch ${APPTAINER_IMAGE_PATH} jupyter $@; }
    ```
    4. You may need to check the **Use Jupyter Lab instead of Jupyter Notebook** box (in case only Jupyter Lab or only Jupyter Notebook is available in the container)
    4. Make sure the two pull down menu under **Run on cluster type** choose `Batch` and `s3df`.
    5. In **Account** box, type in `atlas:usatlas`
    6. In **Partition** choose `ampere` if you want GPUs, or choose `rome` if you don't need a GPU.
    7. Fill the **Number of GPUs** box if you are asking for GPUs.
    8. Your server will be submitted to the queue and will take a minute or so to generate. You will see the **Connect to Jupyter** button when your server has initialized successfully.
</p>
