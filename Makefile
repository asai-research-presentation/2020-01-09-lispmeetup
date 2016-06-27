
GH_USER    = guicho271828
EMACS      = emacs
EMACSFLAGS =
styles     = anorg.sty user.sty
# latex      = pdflatex
# latex      = platex
TEX 	   = platex

ncpu       = $(shell grep "processor" /proc/cpuinfo | wc -l)

.PHONY: auto all img scripts clean allclean html pdf resume index css deploy
.SECONDLY: *.elc *.org.*

all: index nokey pdf resume
html: img css presen.org.html MathJax
pdf: img presen.pdf
nokey: img presen-nokey.pdf
resume: img resume.pdf

deploy: index
	+scripts/deploy.sh git@github.com:$(GH_USER)/$$(basename $$(readlink -ef .)).git

index: html
	cp -f presen.org.html index.html

get-archive = wget -O- $(1) | tar xz ; mv $(2) $(3)

MathJax:
	$(call get-archive, https://github.com/mathjax/MathJax/archive/2.6.1.tar.gz, MathJax-2.6.1, $@)

org-mode:
	$(call get-archive, http://orgmode.org/org-8.2.10.tar.gz, org-8.2.10, $@)
	$(MAKE) -C $@ compile

scripts:
	$(MAKE) -C scripts

auto:
	scripts/make-cycle.sh -j $(ncpu) all

img:
	$(MAKE) -C img
css:
	$(MAKE) -C css

presen.dvi: presen.org.tex
resume.dvi: presen.org.tex
presen-nokey.dvi: presen.org.tex
presen.org: head.org
	touch presen.org

%.org.tex: %.org scripts org-mode
	scripts/org-latex.sh $< $@

%.org.html: %.org scripts org-mode
	scripts/org-html.sh $< $@

%.dvi: %.tex img $(styles)

%.pdf : %.dvi
	nohup bash -c "nohup dvipdfmx -f ipa.map -o $@ $* > /dev/null ; cp $@ ~/Dropbox/repos/presentations/$(shell basename $(CURDIR))-$@" &

clean:
	-rm *~ *.org.* *.pdf \
		*~ *.aux *.dvi *.log *.toc *.bbl \
		*.blg *.utf8 *.elc \
		*.fdb_latexmk __* *.fls *.mtc *.maf *.out index.html

allclean: clean
	git clean -Xfd
	$(MAKE) -C scripts clean
	$(MAKE) -C img clean
	$(MAKE) -C css clean

