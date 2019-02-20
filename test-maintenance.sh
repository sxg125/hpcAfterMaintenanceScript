#!/bin/bash
# Sanjaya Gajurel - created on May 19, 2017
# Implemented on December 22, 2017

#MSG="/tmp/msg"

# Check Connection to Head nodes
sh /etc/admin/cronjob-maintenance/sshConnectionHeadNodes.sh

# Check Connection to Compute Nodes
sh /etc/admin/cronjob-maintenance/sshConnectionCompute.sh

# Check License Status
sh /etc/admin/cronjob-maintenance/licenseStatus.sh  

#Check Mountpint Status and Fix them
sh /etc/admin/cronjob-maintenance/mountfs.sh  

# Check the permission of /tmp Dir and Fix them
sh /etc/admin/cronjob-maintenance/tempPermission.sh

# Check Munge/SLURM Status
sh /etc/admin/cronjob-maintenance/slurm-munge-test.sh

# Check for Machine Check Error (MCE) and Drain the nodes
# sh machineCheckError.sh

# Check for Job Requueued
#sh job-held-state.sh

# Check Epilog Error Failure, fix it and Resume the Node
sh /etc/admin/cronjob-maintenance/Epilog-error.sh

# Check "Job Complete Failure" and resume the node
sh /etc/admin/cronjob-maintenance/job-complete-failure.sh  

# Check Non Responsive Nodes
#sh /etc/admin/cronjob-maintenance/slurmstepdIssue.sh

# Email the status
#mail -s "Check HPC Maintenance Status" sxg125@case.edu < $MSG

# Submit MPI job
#echo "Submitting MPI Job now ...."
#ssh  hpc1x "srun -N 4 -n 16 /home/sxg125/Software/mpi/my_program"

