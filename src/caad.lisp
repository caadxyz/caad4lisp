;; init file

(setq Conf-AutoCAD-Version "2015-")
;; (if (not command-s) (setq command-s command))


(defun in-package(packageName)
  (princ "using caad4lisp package ... " )
  )

(princ "\n ---caad.lsp loading---\n")
;; autolisp command compatibility
(load "command-s.lisp")
;; caad library
(load "util.lisp")
(load "geom.lisp")

;; wall & openning
;; (load "wallx.lsp")
;; (load "walld.lsp")

;; symbole
(load "bubble.lsp")

;; tools
(load "copyrot.lsp")

(princ "\n ---caad.lsp loaded---\n")

(princ)

