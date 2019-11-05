;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; testing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; env init;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun in-package(packageName)
  (princ "\n loading caad4lisp package ...\n " )
)
;; draw a line
(defun drawLine ()
  (command "._line"  "0,0,0" "100,100,0" "")
  )
(defun drawCircle ()
  (command "._circle"  "0,0,0" 50)
  )

;;;; util.lisp ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "util.lisp")

;; Util-Working
(princ "\n---util-working---\n")
(Util-Working)

;; var Util-Math-Fuzz 
(princ "\n---util-math-fuzz---\n")
(princ (> 0.0000011 util-math-fuzz)) 
(princ (= 0.000001 util-math-fuzz)) 
(princ (< 0.0000001 util-math-fuzz)) 
(princ "\n")
(Util-Working)

;; Util-Math-Odd
(princ "\n---util-math-odd---\n")
(princ (Util-Math-Odd? 3)) 
(princ (= nil (Util-Math-Odd? 4)) ) 
(princ "\n")
(Util-Working)

;; Util-Data-GetDataByKey
(princ "\n---util-data-getdatebykey---\n")
(drawLine)
(princ "\n")
(princ (Util-Data-GetDataByKey (list -1 0 10 11)  (entget (entlast)) ))
(princ "\n")
(Util-Working)
Util-Data-GetEntType
(princ "\n---Util-Data-GetEntType---\n")
(princ (Util-Data-GetEntType (entget (entlast)) '("LINE" "CIRCLE")) ) 
(entdel (entlast))
(princ "\n")
(Util-Working)

(princ "\n")
(drawCircle)
(princ "\n")
(princ (Util-Data-GetEntType (entget (entlast))  '("LINE" "CIRCLE")) ) 
(entdel (entlast))
(princ "\n")
(Util-Working)

;;;; geom.lisp ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load "geom.lisp")

;; Geom-Line-MakeStructByEntLine
;; (defun Geom-Line-MakeStructByEntLine(entLine / edata pointsData )
