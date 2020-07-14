#!/bin/bash
echo "Recoding....."
find  . -name "*.srt" -print -exec  echo recode cp1250..utf8  {} \;
echo "Sync ....."
scp -r ../tit  root@kodi:videos/
echo "Deleting ......."
find  . -name "*.srt" -print -delete

