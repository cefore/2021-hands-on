#!/bin/bash

echo "- PUSH Publisher ----------------------------------------"

cefroute add ccnx:/Current-Temp udp 10.0.1.100
cefstatus -v
cefstatus

# python3 /cefore/bin/push-publisher.py >/tmp/video/push-pub.log 2>&1 &
