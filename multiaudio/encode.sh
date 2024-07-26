#!/bin/bash

input=$1
output=$2
langs=$3
#bitrate=2600k
bitrate=1500k

#ffmpeg -y -i $input -c:v libx264 -b:v 2600k -profile:v high -pass 1 -an -f null /dev/null && \
#ffmpeg -i $input -c:v libx264 -b:v 2600k -profile:v high -pass 2 -c:a aac -b:a 128k $output
#
#ffmpeg -y -hwaccel cuda  -i $input -c:v h264_nvenc -b:v $bitrate -profile:v high -pass 1 -an -f null /dev/null
#ffmpeg -hwaccel cuda -i $input -c:v  h264_nvenc  -b:v $bitrate -profile:v high -pass 2  -c:a aac -b:a 128k $output


#ffmpeg -i video.mp4 -i input1.mp3 -i input2.mp3
#       -map 0 -map 1:a -map 2:a
#       -metadata:s:a:0 language=eng
#       -metadata:s:a:1 language=ger
#       -metadata:s:a:2 language=fra
#       -disposition:a:0 default
#       -c:v copy -shortest
#       output.mp4

filename=$(basename -- "$input")
extension="${filename##*.}"
filename="${filename%.*}"


ffmpeg -y -hwaccel cuda  -i $input -c:v h264_nvenc -b:v $bitrate -profile:v high -pass 1 -an -f null /dev/null 
AUDIO_INDEX=1
AUDIO_P0=
AUDIO_P1=
AUDIO_P3=


# add_audio <lang> <file>

add_audio () {
  [ ! -f $2 ] && return     	
  AUDIO_P0="${AUDIO_P0} -i $2"
  AUDIO_P1="${AUDIO_P1} -map ${AUDIO_INDEX}:a"
  AUDIO_P2="${AUDIO_P2} -metadata:s:a:$((AUDIO_INDEX-1)) language=$1"
  AUDIO_INDEX=$((AUDIO_INDEX+1))
}

add_audio "cze" "${langs}/cz/${filename}_czech.mp3"
add_audio "eng" "${langs}/eng/${filename}_english.mp3"
add_audio "ger" "${langs}/de/${filename}_german.mp3"


ffmpeg -hwaccel cuda -i $input ${AUDIO_P0} -map 0 ${AUDIO_P1} ${AUDIO_P2} -disposition:a:0 default  -c:v  h264_nvenc  -b:v $bitrate -profile:v high -pass 2 $output

