#!/bin/bash

for i in `cat names.txt`; do
    num=`echo $i | cut -d'-' -f1`
    mv ${num}.VOB $i
done
