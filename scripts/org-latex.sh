#!/bin/bash

in=$(readlink -ef $1)
out=$(readlink -ef $2)
cd $(dirname $(readlink -ef $0))
emacs --batch --quick --eval "(progn (load-file \"compile-org-latex.el\")(compile-org \"$in\" \"$out\"))"
