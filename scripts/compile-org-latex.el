
(add-to-list 'load-path (concat default-directory "../org-mode/lisp/"))
(require 'ox-latex)
(require 'org-table)
(defun compile-org (in out)
  (require 'ox-latex)
  (require 'org-table)
  (org-version nil t t)
  (find-file in)
  (setf org-latex-image-default-width ""
        ;; org-latex-image-default-height "\\defaultimageheight"
        org-latex-listings 'minted 
        org-latex-minted-langs '((lisp "common-lisp")
                                 (emacs-lisp "common-lisp")
                                 (cc "c++")
                                 (cperl "perl")
                                 (shell-script "bash")
                                 (caml "ocaml"))
        org-export-with-latex 't)
  ;; (setf org-latex-image-default-width "\\defaultimagewidth"
  ;;       ;; org-latex-image-default-height "\\defaultimageheight"
  ;;       )
  ;; (setf org-latex-image-default-width "\\maxwidth{\\defaultimagewidth}"
  ;;       ;; org-latex-image-default-height "\\defaultimageheight"
  ;;       )
  (org-latex-export-as-latex nil nil nil t)
  (write-file out))
