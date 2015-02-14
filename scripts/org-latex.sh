#!/bin/bash

emacs --batch --quick --eval "(progn (load-file \"scripts/compile-org-latex.el\")(compile-org \"$1\" \"$2\"))"
