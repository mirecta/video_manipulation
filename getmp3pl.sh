#!/bin/bash
# sudo apt install python3-pip ffmpeg sox libsox-fmt-all
# pip3 install youtube-dl
#
#youtube-dl -c -x --yes-playlist --audio-format mp3 --quiet --no-warnings

mkdir -p $2
youtube-dl   --quiet --no-warnings --yes-playlist --continue --extract-audio --audio-format mp3  $1


for file in *.mp3
do
	echo -n "Normalize $file ..."
	sox --norm "$file" "$2/$file"
	echo "done"
done
