#!/bin/bash

# Created by Sanjaya Gajurel on May 22, 2017

# Check the status of the head nodes

# Head login nodes
declare LOGIN=<server>
declare VIZ=<server>
declare X=<server>

# Head Master
declare MASTER=<master-node>
declare MGMT=<mgmt-node>
# declare MGMT2=<mgm-node> : This code will run from here
declare XDMOD=<xdmod-server>

declare -a headnodes=("$LOGIN" "$VIZ" "$X" "$MASTER" "$MGMT" "$XDMOD")

echo "Check ssh status of Head Nodes:${headnodes[@]}"
echo "These nodes have ssh connections ..."
for node in "${headnodes[@]}"
do
  ssh -q $node hostname  | awk -F'.' '{print $1}'
