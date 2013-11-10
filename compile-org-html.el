(defvar site-lisp "~/Dropbox/site-lisp/")
(defun site (subdir)
  (concat site-lisp subdir))
(add-to-list 'load-path (site "org-mode/lisp/"))
(add-to-list 'load-path (site "org-mode/contrib/lisp/"))
(add-to-list 'load-path (site "org-mode/contrib/babel/langs/"))

(require 'org)
(autoload 'org-html-export-as-html "ox-html")

(defun compile-org (in out)
  (find-file in)
  (org-html-export-as-html nil nil nil nil)
  (write-file out))
