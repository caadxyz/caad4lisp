(defsystem "caad4lisp"
  :version "v0.001 alpha"
  :author "mahaidong"
  :license "MIT"
  :depends-on ()
  :components (
               (:file "./package")
               (:file "./src/util")
               (:file "./src/geom")
               (:file "./src/wall")
              ) 
  :description "a autolisp architectural tool"
)
