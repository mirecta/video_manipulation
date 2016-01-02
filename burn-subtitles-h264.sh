#!/bin/bash

# M.Talasek c 2016
# -v quiet -stats


function help {

    echo " " 
    echo "USAGE: ./burn-subtitles-h264.sh <movie> <subtitles> <subtitle-enc>"
    echo " "
    echo "      Burn nice big yellow subtitles to movie and recode audio ot mp3 for my tv :)."
    echo "      c 2016 M.Talasek "
    echo " "
}




if  [ "$#" -ne 3 ]
then 
    if [ "$#" -eq 2 ]
    then
        ENC="utf8"
    else
        help
        exit 1
    fi
else
    ENC=$3
fi

MOVIE=$1
SUBS=$2


if [ ! -f "$MOVIE" ]
then
    echo " "
    echo "Movie file ($MOVIE) doesn't exists !!!"
    help
    exit 1
fi

if [ ! -f "$SUBS" ]
then
    echo " "
    echo "Subtitle file ($SUBS)  doesn't exists !!!"
    help
    exit 1
fi


MOVIE_FILENAME="${MOVIE%.*}"
TARGET_MOVIE="${MOVIE_FILENAME}-subburn.avi"
#SUBS_FILENAME="${SUBS%.*}"

#clean target files 

echo -n "Prerun clean ..."

rm -f "${TARGET_MOVIE}"
rm -f "${MOVIE_FILENAME}.ass"

echo "done"

echo  "Start encode subtitles:"

ffmpeg  -v quiet -stats -sub_charenc $ENC -i "$SUBS"  "${MOVIE_FILENAME}.ass"

echo "Encode subtitles done"


echo -n "Change subtitles params ..."
    sed -i 's/16\,\&Hffffff\,\&Hffffff/25\,\&H0bfffb\,\&Hffffff/g' "${MOVIE_FILENAME}.ass" 
echo "done"

echo "Start burn subtitles to movie:"

ffmpeg -v quiet -stats -i "$MOVIE"   -c:a libmp3lame -q:a 1 -c:v libx264 -preset slow -tune film -profile:v main -level 4.0   -vf "ass='${MOVIE_FILENAME}.ass'"  "$TARGET_MOVIE" 

echo "done"



echo -n "Postrun clean ..."
rm -f "${MOVIE_FILENAME}.ass"
echo "done"
