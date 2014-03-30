
EMACS = emacs
EMACSFLAGS =
styles= anorg.sty

.PHONY: all imgs clean allclean

all: presen.org.html presen.pdf resume.pdf imgs

index: all
	cp -f presen.org.html index.html

imgs:
	make -C img

presen.tex: presen.org.tex
resume.tex: presen.org.tex

%.org.tex: %.org compile-org-latex.elc
	emacs --batch --quick --eval "(progn (load-file \"compile-org-latex.el\")(compile-org \"$<\" \"$@\"))"

%.org.html: %.org compile-org-html.elc
	emacs --batch --quick --eval "(progn (load-file \"compile-org-html.el\")(compile-org \"$<\" \"$@\"))"

%.dvi: %.tex imgs $(styles)
	platex -halt-on-error $<
	platex -halt-on-error $<
# pbibtex $*
# platex -halt-on-error $<
# platex -halt-on-error $<

%.pdf : %.dvi
	dvipdfm -o $@ $*

%.elc : %.el
	$(EMACS) -Q --batch $(EMACSFLAGS) -f batch-byte-compile $<

clean:
	rm -f *~ *.org.*  *.elc
	rm -f __*

allclean: clean
	make -C img clean
