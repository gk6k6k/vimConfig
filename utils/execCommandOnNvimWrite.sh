#!/bin/bash
#
#This script will wait for any data on pipe and execute script argument on change
#for example to compile and run unit tests
#
#pre steps:
#mkfifo pipe1
#
#vim command to update pipe on write event:
#:autocmd BufWritePost * silent! !echo "p" > ~/pipe &
#
while true
do
    while read i
    do
        #echo $i
        echo ""
    done < .pipe;
    $1
done

