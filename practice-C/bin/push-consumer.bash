#!/bin/bash

echo "- PUSH Consumer ----------------------------------------"

cefroute add ccnx:/_SF_abcdef_ udp 10.0.1.10

cefstatus -v
cefstatus
