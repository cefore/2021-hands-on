#!/bin/bash

echo "- PUSH Server ----------------------------------------"

cefroute add ccnx:/Current-Temp udp 10.0.1.100

cefstatus -v
cefstatus

