;; generate documentation

(require 'asdf)
(push #p"./" asdf:*central-registry*)
(asdf:load-system "caad4lisp")
(princ "---caad4lisp loaded---")


(require 'codex)
(codex:document :caad4lisp)
(princ "---documentation generated---")

