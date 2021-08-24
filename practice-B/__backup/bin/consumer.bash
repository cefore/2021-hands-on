#!/bin/bash

echo "- Consumer ----------------------------------------"

ifstat -t > /tmp/log/throughput.log &

# cefroute add ccnx:/stream udp 133.69.33.120
# cefroute add ccnx:/stream tcp 133.69.33.120
cefroute add ccnx:/stream tcp 10.0.1.10

cefstatus -v
cefstatus

cefgetstream ccnx:/stream -z 2 >/tmp/log/bbb.mp4