;; init file

(setq Conf-AutoCAD-Version "2015-")
;; (if (not command-s) (setq command-s command))


(defun in-package(packageName)
  (princ "\n loading caad4lisp package ...\n " )
  )

(princ "\n ---start loading caad.lsp---\n")

;; autolisp command compatibility
(load "command-s.lisp")
;; caad library
(load "util.lisp")
(load "geom.lisp")

;; wall & openning
(load "wallx.lisp")
(load "walld.lisp")

;; symbole
(load "bubble.lisp")

;; tools
(load "copyrot.lisp")

(princ "\n ---caad.lsp loaded---\n")

(princ)

