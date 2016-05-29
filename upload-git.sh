#!/bin/bash

git clone --mirror . $1

echo 
read -p "untrack remote and track $1 ? [yYnN]" -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]
then
    # do dangerous stuff
    git remote add uploaded $1
    git branch -u uploaded
fi

