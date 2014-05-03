
EMACS      = emacs
EMACSFLAGS =
styles     = anorg.sty user.sty
# latex      = pdflatex
latex      = platex

.PHONY: all img clean allclean html pdf resume index css
.SECONDLY: *.elc *.org.*

all: index pdf resume
html: img css presen.org.html 
pdf: img presen.pdf
resume: img resume.pdf
index: html
	cp -f presen.org.html index.html

img:
	make -C img
css:
	make -C css

presen.dvi: presen.org.tex
resume.dvi: presen.org.tex

%.org.tex: %.org compile-org-latex.elc
	emacs --batch --quick --eval "(progn (load-file \"compile-org-latex.el\")(compile-org \"$<\" \"$@\"))"

%.org.html: %.org compile-org-html.elc
	emacs --batch --quick --eval "(progn (load-file \"compile-org-html.el\")(compile-org \"$<\" \"$@\"))"

ifeq ($(latex),platex)
%.dvi: %.tex img $(styles)
	$(latex) -halt-on-error $<
	$(latex) -halt-on-error $<
%.pdf : %.dvi
	dvipdfmx -f ipa.map -o $@ $*
else
%.dvi: %.tex img $(styles)
	$(latex) -output-format=dvi -halt-on-error $<
	$(latex) -output-format=dvi -halt-on-error $<
%.pdf : %.dvi
	dvipdfmx -o $@ $*
endif

%.elc : %.el
	$(EMACS) -Q --batch $(EMACSFLAGS) -f batch-byte-compile $<

clean:
	-rm -f *~ *.org.* *.pdf \
		*~ *.aux *.dvi *.log *.toc *.bbl \
		*.blg *.utf8 *.elc \
		*.fdb_latexmk __* *.fls *.mtc *.maf *.out index.html

allclean: clean
	make -C img clean
	make -C css clean
