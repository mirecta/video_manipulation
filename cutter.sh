#!/bin/bash

extension="${1##*.}"
filename="${1%.*}"

if [ "$#" -ne 3 ]; then
       	ffmpeg -ss $2 -i $1   -acodec copy -vcodec copy ${filename}_cut.${extension}
else

	ffmpeg -ss $2 -i $1 -to $3  -acodec copy -vcodec copy ${filename}_cut.${extension}

fi
