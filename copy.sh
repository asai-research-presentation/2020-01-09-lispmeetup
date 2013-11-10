#! /bin/bash

d=$(dirname $0)

ls -1 $d | while read line
do
    cp -ru $d/$line ./
done

if [ ! -a ./presen.org ]
then
    sed -e "s|@HOME|$HOME|g" $d/presen.org > ./presen.org
fi
