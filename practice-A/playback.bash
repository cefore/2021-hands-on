#!/usr/bin/env bash

playback_count=0

echo -n "Trying to play the video "
while true
do
    if [ $playback_count -gt 0 ]; then
	echo "You've already watched the video, so stopping the playback."
	exit 0
    fi
    
    if [ -e /tmp/log/bbb.mp4 ]; then
	playback_count=$(expr $playback_count + 1)
	# ffplay -an /tmp/log/bbb.mp4
	ffplay -volume 10 /tmp/log/bbb.mp4
    else
	echo -n "."
	sleep 2
    fi
done






