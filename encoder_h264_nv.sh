#!/bin/bash


file="$1"
    MOVIE_FILENAME="${file%.*}"
    TARGET_MOVIE="${MOVIE_FILENAME}-h264.avi"
echo "Encode movie $file "

#ffmpeg  -stats   -i "$file"   -c:a libmp3lame -b:v 1800k -q:a 1 -c:v h264_nvenc  -profile:v main -level 4.0     "$TARGET_MOVIE"
ffmpeg -threads 4 -hwaccel cuvid -i "$file" -c:v h264_nvenc -profile:v main -level:v 4.1 -preset slow -c:a libmp3lame  -q:a 1  "$TARGET_MOVIE"
#-filter:v scale_npp=w=1920:h=1080:format=yuv420p:interp_algo=lanczos \

echo "done"

