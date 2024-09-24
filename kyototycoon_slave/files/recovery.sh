#!/bin/bash

KTPATH=/opt/kyototycoon
DBNAME=casket-0001.kch
ULOGDIR=0001-ulog

if [ ! -e $KTPATH/$DBNAME ]

then
        TS=`ls -rt $KTPATH/db_backup/* | tail -1 | cut -d"." -f 3`
        cd $KTPATH/db_backup ; cp  $DBNAME.$TS ../$DBNAME
        cd $KTPATH ; kttimedmgr recover -ts $TS $DBNAME $ULOGDIR
fi

