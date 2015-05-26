#!/bin/bash

for file in $(find -regex ".*\.\(png\|jpg\)")
do
    ebb -O -x $file > ${file%.*}.xbb
    cp ${file%.*}.xbb ${file%.*}.bb
done
