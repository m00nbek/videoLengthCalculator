#!/usr/bin/env bash

LENGTH=00:00:00

echo Calculating...

# Get all the video duration & save them to durations.txt
for video in *.mp4; do
  echo $(ffmpeg -i "$video" 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//) >> durations.txt
done


# Read the durations.txt and calculate all the durations
echo $(awk -F: '{ n=0; for(i=NF; i>=1; --i) secs += $i * 60 ^ n++ } END { print secs }' durations.txt) >> seconds.txt

# Turn the seconds into date format
LENGTH=$(awk -F: '
  { n=0; for(i=NF; i>=1; --i) secs += $i * 60 ^ n++ }
  END {
    hours   = int(secs / 3600)
    minutes = int((secs - hours * 3600) / 60)
    secs    = secs % 60
    printf "%02d:%02d:%05.2f\n", hours, minutes, secs
  }
  ' seconds.txt)

# clean up
rm -rf durations.txt seconds.txt

#final result
echo RESULT: $LENGTH
