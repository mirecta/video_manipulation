#!/bin/bash


for file in $@; do
    MOVIE_FILENAME="${file%.*}"
    TARGET_MOVIE="${MOVIE_FILENAME}-h264.avi"
echo "Encode movie $file "

ffmpeg  -stats   -i "$file"   -c:a libmp3lame -b:v 1600k -q:a 1 -c:v h264_nvenc -preset slow -tune film -profile:v main -level 4.0     "$TARGET_MOVIE"

echo "done"

done
