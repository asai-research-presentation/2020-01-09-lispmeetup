
EMACS = emacs
EMACSFLAGS =
styles=

.PHONY: all imgs clean allclean

all: presen.org.html compile-main-org.elc imgs

imgs:
	make -C img

%.org.tex: %.org compile-org-latex.elc
	emacs --batch --quick --eval "(progn (load-file \"compile-org-latex.el\")(compile-org \"$<\" \"$@\"))"

%.org.html: %.org compile-org-html.elc
	emacs --batch --quick --eval "(progn (load-file \"compile-org-html.el\")(compile-org \"$<\" \"$@\"))"

%.dvi: %.tex imgs $(styles) references.bib
	platex -halt-on-error $<
	platex -halt-on-error $<
	bibtex $*
	platex -halt-on-error $<
	platex -halt-on-error $<

%.pdf : %.dvi
	dvipdfm -o $@ $*

%.elc : %.el
	$(EMACS) -Q --batch $(EMACSFLAGS) -f batch-byte-compile $<

clean:
	rm -f *~ *.org.*  *.elc
	rm -f __*

allclean: clean
	make -C img clean
