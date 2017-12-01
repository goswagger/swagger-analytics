#!/bin/sh

# ratelimiter.sh
# 
#
# Created by James on 12/1/17.
# Copyright 2017 Swagger. All rights reserved.

ARGS=1
E_BADARGS=85
E_NOFILE=86
SUCCESS=0
if [ $# -ne ""$ARGS"" ]  # Correct number of arguments passed to script?
then
echo ""Usage: `basename $0` filenamenoextension""
exit $E_BADARGS
fi

if [ ! -f ""$1.sh"" ]       # Check if file exists.
then
echo ""File \""$1.sh\"" does not exist.""
exit $E_NOFILE
fi

MAX=590
PART=X-RateLimit-Usage
PARTDATE=Date:
RESETMINS=00,15,30,45
cat $1.sh | while read -r cmd; do
USE=`grep $PART hdr.out | awk '{print $2}' | cut -d',' -f1`
if [ $USE = $MAX ]; then
echo "Max rate limit met. Waiting until quarter hour reset"
sleep 1m
while [ ! $RESETMINS =~ $(date +%M)  ]; do sleep 30s; echo "Sleeping"; done
fi
echo "Processing $1.sh $USE $cmd"
content="$($cmd)"
echo "$content" >> $1.json
done
exit $SUCCESS
