#!/bin/bash

LENGTH=0

echo Calculating...
LOOP=0

for video in $(ls | grep .mp4)
do
	LOOP=$(($LOOP+1))
	TIME=$(ffmpeg -i $video 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//)
	TIME=${TIME::8}
	LENGTH=$(( $LENGTH + $(echo $TIME | awk -F: '{ print ($1 * 3600) + ($2 * 60) + $3 }')))
done

echo LOOP: $LOOP
echo RESULT: $(date -u -r $LENGTH +%T)
