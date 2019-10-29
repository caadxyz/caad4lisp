;; generate documentation

(require 'asdf)
(push #p"./" asdf:*central-registry*)
(asdf:load-system "caad4lisp")
(princ "---caad4lisp loaded---")


(require 'codex)
(codex:document :caad4lisp)
(princ "---documentation generated---")

(sb-ext:run-program "/bin/bash" 
                    (list "-c" "cp -r ./docs/build/caad4lisp/html/. ./docs/gh-pages") 
                    :input nil 
                    :output *standard-output*)
(princ "---documentation copied to gh-pages folder---")

