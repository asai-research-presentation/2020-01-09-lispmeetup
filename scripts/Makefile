
all: compile-org-html.elc compile-org-latex.elc

%.elc : %.el
	$(EMACS) -Q --batch $(EMACSFLAGS) -f batch-byte-compile $<

clean:
	rm *.elc
