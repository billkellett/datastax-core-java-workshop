#!/bin/bash

echo "Begin loading workshop notebooks"

set -x

IP=$(ifconfig | awk '/inet/ { print $2 }' | egrep -v '^fe|^127|^192|^172|::' | head -1)
IP=${IP#addr:}

if [[ $HOSTNAME == "node"* ]] ; then 
    #rightscale
    IP=$(grep $(hostname)_ext /etc/hosts | awk '{print $1}')
fi

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    IP=localhost
fi

# Swap out your file name here
curl -H "Accept-Encoding: gzip" -X POST -F 'file=@notebooks/Java_Core_Programming_-_All_Labs.tar' http://"$IP":9091/api/v1/notebooks/import &> /dev/null

echo "Finished loading workshop notebooks"
