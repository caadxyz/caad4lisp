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
(princ "\n------------------------------\n")
(load "util.lisp")
(princ "\n------------------------------\n")

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
(princ "\n------------------------------\n")
(load "geom.lisp")
(princ "\n------------------------------\n")

;; Geom-XYZ
(princ "\n---XYZ---\n")
(princ "\nX\n")
(princ (Geom-X '(0.0 1.0 2.0)))
(princ "\nY\n")
(princ (Geom-Y '(0.0 1.0 2.0)))
(princ "\nZ\n")
(princ (Geom-Z '(0.0 1.0 2.0)))
(princ "\n")
(Util-Working)
(princ)

;; Geom-Line-MakeStruct
(princ "\n---Geom-Line-MakeStruct---\n")
(drawLine)
(princ "\n---(entlast)---\n")
(princ (Geom-Line-MakeStruct (entlast) )) 
(princ "\n---(entget (entlast))---\n")
(princ (Geom-Line-MakeStruct (entget (entlast) ) ))
(entdel (entlast))
(princ "\n")
(Util-Working)
(princ)

;; Geom-Line-Flip
(princ "\n---Geom-Line-Flip---\n")
(drawLine)
(princ "\n")
(princ (cadr (Geom-Line-MakeStruct (entlast) )) ) 
(princ "\n")
(Geom-Line-Flip  (entlast) )
(princ "\n")
(princ (cadr (Geom-Line-MakeStruct (entlast) )) ) 
(entdel (entlast))
(princ "\n")
(Util-Working)
(princ)
