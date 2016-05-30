#!/bin/bash

try_exit (){
    echo $*
    $* || {
        status=$?
        echo "Error occured. status: $status"
        exit $status
    }
}

dest=${1:-~/Dropbox/repos/presentations/$(basename $(readlink -ef .)).git}

read -p "upload to $dest ? [y*]: " -r

try_exit test $REPLY == y
try_exit git clone --mirror . $dest

echo 
read -p "untrack remote and track $dest ? [y*]: " -r

try_exit test $REPLY == y
try_exit git remote add uploaded $dest
try_exit git fetch --all
try_exit git branch -u uploaded/$(git rev-parse --abbrev-ref HEAD)


