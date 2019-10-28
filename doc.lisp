;; generate documentation

(require 'asdf)
(push #p"./" asdf:*central-registry*)
(asdf:load-system "caad4lisp")
(princ "\n---caad4lisp loaded---\n")


(require 'codex)
(codex:document :caad4lisp)
(princ "\n---documentation generated---\n")

