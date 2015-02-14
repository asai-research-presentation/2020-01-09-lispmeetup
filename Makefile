
EMACS      = emacs
EMACSFLAGS =
styles     = anorg.sty user.sty
# latex      = pdflatex
latex      = platex

ncpu       = $(shell grep "processor" /proc/cpuinfo | wc -l)

.PHONY: auto all img scripts clean allclean html pdf resume index css
.SECONDLY: *.elc *.org.*

all: index pdf resume
html: img css presen.org.html 
pdf: img presen.pdf
resume: img resume.pdf
index: html
	cp -f presen.org.html index.html

scripts:
	$(MAKE) -C scripts

auto:
	scripts/make-cycle.sh -j $(ncpu)

img:
	make -C img
css:
	make -C css

presen.dvi: presen.org.tex
resume.dvi: presen.org.tex
presen.org: head.org
	touch presen.org

%.org.tex: %.org scripts
	scripts/org-latex.sh $< $@

%.org.html: %.org scripts
	scripts/org-html.sh $< $@

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

clean:
	-rm -f *~ *.org.* *.pdf \
		*~ *.aux *.dvi *.log *.toc *.bbl \
		*.blg *.utf8 *.elc \
		*.fdb_latexmk __* *.fls *.mtc *.maf *.out index.html

allclean: clean
	make -C img clean
	make -C css clean
