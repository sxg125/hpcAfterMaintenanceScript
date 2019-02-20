# HPC After Maintenance Test Script
This bash script helps you to carry out basic HPC tests after the maintenance before opening the cluster to the users. The script has assumed that you are using SLURM, xCAT, and XDMOD. However, you can modify it according to your need. The content in angular brackets needs to be replaced as per your need. The script can be well suited to run as a cron job (hourly) so that it can be monitored every hour. Moreover, the script will attempt to fix the issue.


The master script "test-maintenance.sh" runs all other scripts
## Usage
sh test-maintenance.sh

