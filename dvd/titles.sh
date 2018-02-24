#!/bin/bash
# count Titles, and count Cells per title.
# eg. ${cell[1]}      is the Count of Cells for the first title
#     ${cell[titles]} is the Count of Cells for the last title

titles=`lsdvd | grep Title | wc -l`

from_title=1
to_title=$titles
for ((c = $from_title; c < $to_title; c++)) ;do
    mplayer dvd://$c -dumpstream -dumpfile $c.VOB
done


