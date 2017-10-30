#!/bin/bash

filename="${1%.*}"

ffmpeg -i "$1"  -c:v libx264 -preset slower -tune film -profile:v main -level 4.0  -c:a libmp3lame -q:a 1 "${filename}-tvfix.avi" && rm "$1"
