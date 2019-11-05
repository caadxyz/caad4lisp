;; testing

;; init evn
(defun in-package(packageName)
  (princ "\n loading caad4lisp package ...\n " )
  )
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

;; Util-Data-GetDataByKey
