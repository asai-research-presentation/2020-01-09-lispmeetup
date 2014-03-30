(defvar site-lisp "~/Dropbox/site-lisp/")
(defun site (subdir)
  (concat site-lisp subdir))
(add-to-list 'load-path (site "org-mode/lisp/"))
(add-to-list 'load-path (site "org-mode/contrib/lisp/"))
(add-to-list 'load-path (site "org-mode/contrib/babel/langs/"))

(require 'org)
(autoload 'org-latex-export-as-latex "ox-latex")

(defun compile-org (in out)
  (find-file in)
  (org-latex-export-as-latex nil nil nil t)
  (write-file out))
