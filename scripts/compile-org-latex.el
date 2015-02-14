
(add-to-list 'load-path (concat default-directory "org-mode/lisp/"))
(defun compile-org (in out)
  (require 'ox-latex)
  (require 'org-table)
  (find-file in)
  (org-latex-export-as-latex nil nil nil t)
  (write-file out))
