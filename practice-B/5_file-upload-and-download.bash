#!/usr/bin/env bash

set -e

echoI() { printf "\033[34m[INFO] $*\033[m\n"; }
echoS() { printf "\033[32m[SUCCESS] $*\033[m\n"; }
echoW() { printf "\033[33m[WARNING] $*\033[m\n"; }
echoE() { printf "\033[31m[ERROR] $*\033[m\n"; exit 1; }

echoI "* SETUP PROCESS STARTS."

echoI "(4-1)-(4) Start cefnetd at b-consumer."
docker exec b-consumer bash -c "cefnetdstop > /dev/null 2>&1 || :"
echoI "[b-consumer] cefnetdstart"
docker exec b-consumer bash -c "cefnetdstart"
echoI "[b-consumer] cefstatus"
docker exec b-consumer bash -c "cefstatus"

echoI "(4-2)-(5) Start cefnetd at b-router."
docker exec b-router bash -c "cefnetdstop > /dev/null 2>&1 || :"
echoI "[b-router] cefnetdstart"
docker exec b-router bash -c "cefnetdstart"
echoI "[b-router] cefstatus"
docker exec b-router bash -c "cefstatus"

echoI "(4-2)-(6,7) Start csmgrd and cefnetd at b-producer."
docker exec b-producer bash -c "cefnetdstop > /dev/null 2>&1 || :"
docker exec b-producer bash -c "while pgrep cefnetd > /dev/null; do sleep 0.5; done"
docker exec b-producer bash -c "csmgrdstop > /dev/null 2>&1 || :"
docker exec b-producer bash -c "while pgrep csmgrd > /dev/null; do sleep 0.5; done"
echoI "[b-producer] csmgrdstart"
docker exec b-producer bash -c "csmgrdstart"
echoI "[b-producer] cefnetdstart"
docker exec b-producer bash -c "cefnetdstart"
echoI "[b-producer] cefstatus"
docker exec b-producer bash -c "cefstatus"
echoI "[b-producer] csmgrstatus ccnx:/"
docker exec b-producer bash -c "csmgrstatus ccnx:/"

echoS "* SETUP PROCESS COMPLETED."
echoI "* Wait 5 seconds or press any key to run upload process..."
read -n 1 -t 5 || :

echoI "(5-1) Upload file."
echoI "[b-producer] (2) Create hello.txt."
docker exec b-producer bash -c "echo hello > hello.txt"
echoI "[b-producer] (3) cefputfile ccnx:/test/hello.txt"
docker exec b-producer bash -c "cefputfile ccnx:/test/hello.txt"
echoI "[b-producer] (4) csmgrstatus"
sleep 3.0
docker exec b-producer bash -c "csmgrstatus ccnx:/"

echoS "* UPLOAD PROCESS COMPLETED."
echoI "* Wait 5 seconds or press any key to run download process..."
read -n 1 -t 5 || :

echoI "(5-2) Download file."
echoI "[b-consumer] (2) cefgetfile ccnx:/test/hello.txt"
docker exec b-consumer bash -c "cefgetfile ccnx:/test/hello.txt"
echoI "[b-consumer] (3) cat hello.txt"
docker exec b-consumer bash -c "cat hello.txt"
echoI "[b-consumer] (4) ccninfo ccnx:/test/hello.txt -c #reply from localcache"
docker exec b-consumer bash -c "ccninfo ccnx:/test/hello.txt -c"
echoI "[b-producer] (5) ccninfo ccnx:/test/hello.txt -c #reply from csmgrd"
docker exec b-producer bash -c "ccninfo ccnx:/test/hello.txt -c"

echoS "* DOWNLOAD PROCESS COMPLETED."
