#!/bin/bash
# sudo apt install python3-pip ffmpeg sox libsox-fmt-all
# pip3 install youtube-dl
#
#youtube-dl -c -x --yes-playlist --audio-format mp3 --quiet --no-warnings

yt-dlp   -i --no-warnings --yes-playlist --continue --extract-audio --audio-format mp3  $1

mp3gain -c -r *.mp3


