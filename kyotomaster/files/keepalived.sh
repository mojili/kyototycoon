#!/bin/bash 


KTPATH=/opt/kyototycoon
KTSPS=`pgrep -x ktserver`

if [ ! -e $KTPATH/casket* ] || [ -z $KTSPS ]

then
        exit 1
fi


