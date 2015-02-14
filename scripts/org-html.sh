#!/bin/bash

emacs --batch --quick --eval "(progn (load-file \"scripts/compile-org-html.el\")(compile-org \"$1\" \"$2\"))"

