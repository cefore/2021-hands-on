#!/bin/bash

echo "- Publisher ----------------------------------------"
cefstatus -v
cefstatus
# echo hello > test
# cefputfile ccnx:/test
# echo hello > stream

cat /cefore/bin/bbb.mp4 | cefputstream ccnx:/stream -r 10 -b 1400 &
