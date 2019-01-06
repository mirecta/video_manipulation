#!/bin/bash

filename="${1%.*}"

ffmpeg -i "$1"  -c:v copy  -c:a libmp3lame -q:a 1 "${filename}-tvfix.avi" && rm "$1" 
