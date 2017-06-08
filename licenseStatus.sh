#!/bin/bash

# Created by Sanjaya Gajurel in May 25, 2017

declare -a ports=("<port#>@<server>" "<port#>@<server>" "<port#>@<server>" "<port#>@<server>")
echo "Licenses for Schrodinger, Matlab MDCS, Matlab PCT to be monitired ....."

for i in ${ports[@]}
do
 ssh <master-node> /usr/local/matlab/R2015b/etc/lmstat -a -c $i | grep UP | sed -n 2p
done

# for Mathematica
echo "Checking Licenses for Mathematica ...."
ssh <master-node> /usr/local/mathematica/MathLM/monitorlm -format text | grep "MathLM Version"
