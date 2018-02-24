#!/bin/bash
# count Titles, and count Cells per title.
# eg. ${cell[1]}      is the Count of Cells for the first title
#     ${cell[titles]} is the Count of Cells for the last title

eval $(lsdvd | sed -n 's/Title: \([0-9]\+\), .* Chapters: \([0-9]\+\), Cells: .*/cells[$((10#\1))]=$((10#\2));/p')
titles=${#cells[@]}

title_num=$1
from_cell=1
#to_cell=$titles
to_cell=${cells[title_num]}
echo $from_cell  $to_cell

# physical DVD
  for ((c = $from_cell; c < $to_cell; c++)) ;do
    mplayer dvd://$title_num -chapter $c-$c -dumpstream -dumpfile $c.VOB
  done

