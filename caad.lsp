;; init file

(setq Conf-AutoCAD-Version "2015-")
;; (if (not command-s) (setq command-s command))

(princ "\n ---caad.lsp loading---\n")
;; autolisp command compatibility
(load "command-s.lsp")
;; caad library
(load "util.lsp")
(load "geom.lsp")

;; wall & openning
(load "wallx.lsp")
(load "walld.lsp")

;; symbole
(load "bubble.lsp")

;; tools
(load "copyrot.lsp")

(princ "\n ---caad.lsp loaded---\n")

(princ)

