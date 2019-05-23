#!/bin/bash

# Sometimes opscenter needs to be bounced for the metrics dashboard to appear
# May be due to startup order in startup scripts
# This is temporary until assethub is fixed
if [ `hostname` == 'node0' ]
then

  sudo service opscenterd restart 

fi
