(defsystem "caad4lisp"
  :version "0.1.0"
  :author "mahaidong"
  :license "MIT"
  :depends-on ()
  :components (
               (:file "package")
               (:file "./src/util")
               (:file "./src/geom")
              ) 
  :description "caad4lisp library"
)
