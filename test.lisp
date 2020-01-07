


(ql:quickload :trivial-macroexpand-all)
(use-package :trivial-macroexpand-all)

(define-condition for-found (error) ((args :initarg :args :reader args)))
(defmacro for (&rest args)
  (cerror "ignore" 'for-found :args args)
  '(progn))

(defmacro iter (&body body &environment e)
  (let (metadata)
    (handler-bind ((for-found
                    (lambda (c)
                      (push c metadata) ; (1)
                      (continue c))))
      (let ((body (macroexpand-all `(progn ,@body) e)))
        (wrap metadata body)))))

(iter (for i below 5)
      (print i))

(defun wrap (metadata body)
  (let ((metadata (mapcar #'args metadata)))
    `(do ,(mapcar (lambda (m)
                    (let ((var (first m)))
                      `(,var 0 (1+ ,var))))
                  metadata)
         ((and ,@(mapcar (lambda (m)
                           `(< ,(first m) ,(third m)))
                         metadata)))
       ,body)))
