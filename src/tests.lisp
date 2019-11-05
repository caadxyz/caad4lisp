;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; init env
(defun in-package(packageName)
  (princ "\n loading caad4lisp package ...\n " )
)

;;;; util.lisp ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "util.lisp")

;; fun util-working
(princ "\n---util-working---\n")
(princ "\n---1---\n")
(Util-Working)
(princ "\n---2---\n")
(Util-Working)
(princ "\n---3---\n")
(Util-Working)
(princ)

;; var util-math-fuzz 
(princ "\n---util-math-fuzz---\n")
(princ (> 0.0000011 util-math-fuzz)) 
(princ (= 0.000001 util-math-fuzz)) 
(princ (< 0.0000001 util-math-fuzz)) 
(princ)


;; util-math-odd
(princ "\n---util-math-odd---\n")
(princ (Util-Math-Odd? 3)) 
(princ (= nil (Util-Math-Odd? 4)) ) 
(princ)

;; Util-Data-GetDataByKey  & Util-Data-GetEntType
(princ "\n---util-data-getdatebykey---\n")
(command "._line"  "0,0,0" "100,100,0" "")
(setq edata0 (entget (entlast)))
(princ "\n")
(princ (Util-Data-GetDataByKey '(-1 0 10 11) edata0 ))
(princ "\n---util-data-getenttype---\n")
(princ (Util-Data-GetEntType edata0 '("LINE" "CIRCLE")) ) 
(princ "\n")
(command "._circle"  "0,0,0" 50)
(princ "\n")
(setq edata1 (entget (entlast)))
(princ "\n")
(princ (Util-Data-GetEntType edata1 '("LINE" "CIRCLE")) ) 
(princ)

;;;; geom.lisp ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "geom.lisp")

