# HPC After Maintenance Test Script
This bash script helps you to carry out basic HPC tests after the maintenance before opening the cluster to the users. The script has assumed that you are using SLURM, xCAT, and XDMOD. However, you can modify it according to your need. The content in angular brackets needs to be replaced as per your need.


The master script "test-maintenance.sh" runs all other scripts
## Usage
sh test-maintenance.sh

## output
```
These nodes have ssh connections ...
<list-of-servers>
Licenses for Schrodinger, Matlab MDCS, Matlab PCT, ANSYS, PGI,INTEL & COMSOL to be monitired .....
    SCHROD: UP v11.10
       MLM: UP v11.14.0
       MLM: UP v11.13.0
  ansyslmd: UP v11.13.1
   pgroupd: UP v11.13.1
     INTEL: UP v11.13.1
  LMCOMSOL: UP v11.12.0
Checking Licenses for Mathematica ....
Could not find a MathLM server.
The mountpoints to be monitored for head nodes are: /mnt/projects /mnt/genetics /home /scratch /usr/local /mnt/pan
The mountpoints to be monitored for compute nodes are: /mnt/projects /mnt/genetics /home /scratch /usr/local /mnt/pan
Check the following nodes for Missing Mount Points ....
<node>: df: `/tmp/SECUPD': Input/output error

Slurm is not running on .....
<node>: ssh: connect to host <node> port 22: No route to host

Munge is not working on .....
<node>: ssh: connect to host comp077 port 22: No route to host

Submitting MPI Job now ....
srun: job 1236407 queued and waiting for resources
srun: job 1236407 has been allocated resources
Hello World from Node 13 of 16
Hello World from Node 14 of 16
...
```
