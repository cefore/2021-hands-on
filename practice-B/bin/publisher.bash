#!/bin/bash

echo "- Publisher ----------------------------------------"
cefstatus -v
cefstatus

cat /cefore/bin/bbb.mp4 | cefputstream ccnx:/stream -r 1.2 -b 1400 &
