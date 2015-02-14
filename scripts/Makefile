
all: compile-org-html.elc compile-org-html.elc

%.elc : %.el
	$(EMACS) -Q --batch $(EMACSFLAGS) -f batch-byte-compile $<

