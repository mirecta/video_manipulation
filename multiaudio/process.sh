#!/bin/bash

FILES="*.mp4"

for f in $FILES
do
  echo -n "Processing $f file... "
  # take action on each file. $f store current file name
  ./encode.sh $f result/$f ../audio
 echo "done" 
done
