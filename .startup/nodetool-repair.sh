#!/bin/bash
 
# Nodetool repair for Workshop
#
echo "Starting nodetool repair"
if [ `hostname` == 'node0' ]
then

  #Race Condition DSE has not started
  echo "Has DSE Started?"
  if ! nc -z node0 9042; then

    counter=0
    iterations=36
    sleepInterval=5

    echo "Waiting for DSE to start..."
    while  ! nc -z node0 9042; do

       echo "Waiting for DSE... Iteration: $counter Sleep: $sleepInterval seconds..."

       sleep $sleepInterval

       counter=$((counter+1))

       if [[ $counter -gt $iterations ]]; then
         echo "DSE has not started yet. Setup tables may fail."
         break
       fi
    done

   #run repair in case any tables changed replication factor
   nodetool repair -pr

   sleep 10s
  fi
fi
echo "Finished nodetool repair"