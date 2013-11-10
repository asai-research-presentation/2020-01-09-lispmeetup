#! /bin/bash

d=$(dirname $0)

ls -1 $d | while read line ; do cp -rn $d/$line ./ ; done
