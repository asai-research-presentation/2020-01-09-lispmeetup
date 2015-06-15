
EMACS      = emacs
EMACSFLAGS =
styles     = anorg.sty user.sty
# latex      = pdflatex
# latex      = platex
TEX 	   = platex

ncpu       = $(shell grep "processor" /proc/cpuinfo | wc -l)

.PHONY: auto all img scripts clean allclean html pdf resume index css
.SECONDLY: *.elc *.org.*

all: index nokey
html: img css presen.org.html MathJax
pdf: img presen.pdf
nokey: img presen-nokey.pdf
resume: img resume.pdf
index: html
	cp -f presen.org.html index.html

MathJax:
	git clone --depth=1 https://github.com/guicho271828/MathJax.git

scripts:
	$(MAKE) -C scripts

auto:
	scripts/make-cycle.sh -j $(ncpu)

img:
	$(MAKE) -C img
css:
	$(MAKE) -C css

presen.dvi: presen.org.tex
resume.dvi: presen.org.tex
presen-nokey.dvi: presen.org.tex
presen.org: head.org
	touch presen.org

%.org.tex: %.org scripts
	scripts/org-latex.sh $< $@

%.org.html: %.org scripts
	scripts/org-html.sh $< $@

%.dvi: %.tex img $(styles)

%.pdf : %.dvi
	dvipdfmx -f ipa.map -o $@ $*

clean:
	-rm -f *~ *.org.* *.pdf \
		*~ *.aux *.dvi *.log *.toc *.bbl \
		*.blg *.utf8 *.elc \
		*.fdb_latexmk __* *.fls *.mtc *.maf *.out index.html

allclean: clean
	$(MAKE) -C img clean
	$(MAKE) -C css clean

