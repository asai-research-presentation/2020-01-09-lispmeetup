
(add-to-list 'load-path (concat default-directory "../org-mode/lisp/"))
(add-to-list 'load-path (concat default-directory "../htmlize"))

(defun compile-org (in out)
  (require 'ox-html)
  (require 'org-table)
  (find-file in)
  (org-html-export-as-html nil nil nil nil)
  (write-file out))
