#!/bin/bash

# Created by Sanjaya Gajurel in May 25, 2017

declare -a ports=("<port#>@<server>" "<port#>@<server>" "<port#>@<server>" "<port#>@<server>")
echo "Licenses for Schrodinger, Matlab MDCS, Matlab PCT to be monitired ....."

echo "Licenses for Schrodinger, Matlab MDCS, Matlab PCT, ANSYS, PGI,INTEL & COMSOL to be monitired ....." > $MSG

for i in ${ports[@]}
do
 ssh <license-server> <path-to-lmstat>/lmstat -a -c $i | grep UP | sed -n 2p | wc -l | grep 0 > $filename 2> /tmp/errfile
 if [ -s $filename ]
then
  ssh <license-server> <path-to-lmstat>/lmstat -a -c $i | grep UP | sed -n 2p >> $MSG
  mail -s "Check the Software Licenses" <email-address> < $MSG
fi

done

# for Mathematica
echo "Checking Licenses for Mathematica ...." >> $MSG
ssh <license-server> <path-to-monitorlm>/monitorlm -format text | grep "MathLM Version" | wc -l | grep 0 > $filename 2> /tmp/errfile
if [ -s $filename ]
then
  ssh<license-server> <path-to-monitorlm>/monitorlm -format text | grep "MathLM Version" >> $MSG
  echo "Trying to Re-start Mathlm" >> $MSG
  systemctl restart mathlm
  mail -s "Check Mathematica  Licenses" <email-address> < $MSG
fi
