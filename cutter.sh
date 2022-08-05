#!/bin/bash

extension="${1##*.}"
filename="${1%.*}"

if [ "$#" -ne 4 ]; then
       	ffmpeg -ss $3 -i $1   -acodec copy -vcodec copy ${filename}_cut.${extension}
else

	ffmpeg -ss $3 -i $1 -to $4  -acodec copy -vcodec copy ${filename}_cut.${extension}

fi
