
all: compile-org-html.elc compile-org-html.elc

%.elc : %.el org-mode
	$(EMACS) -Q --batch $(EMACSFLAGS) -f batch-byte-compile $<

org-mode:
	git clone -b release_8.2.10 --depth=1 git://orgmode.org/org-mode.git
