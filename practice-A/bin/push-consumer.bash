#!/bin/bash

echo "- PUSH Consumer ----------------------------------------"

# cefroute add ccnx:/_SF_PUSH_ udp 10.0.1.10
cefroute add ccnx:/_SF_abcdef_ udp 10.0.1.10

cefstatus -v
cefstatus

# python3 /cefore/bin/push-consumer.py >/tmp/video/push-con.log 2>&1 &
