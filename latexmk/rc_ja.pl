# -*- cperl -*-
# latexmkrc

$latex         = 'platex -shell-escape';
$bibtex        = 'pbibtex';
$dvipdf = "dvipdfm %O -f latexmk/ipa.map -o %D %S";
