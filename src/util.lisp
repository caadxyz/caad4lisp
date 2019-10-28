(in-package :caad4lisp)

;; A real number defining the maximum amount by which expr1 and expr2 can differ
;; and still be considered equal.
(setq Util-Fuzz 1.0e-6)

;;;; debug程序加载进程情况
(setq @Util-Working
      '("\\" "|" "/" "-"))
;;;; function: Util-Working
(defun Util-Working ()
  "debug the code loading process"
  ; Backspace
  (prompt "\010")
  (setq @Util-Working
        (append
         (cdr @Util-Working)
         (list
          (princ (car @Util-Working)))
         )
        )
  )

;; Parameters:
;; number: int
;; Return
;; bool: True, if the parameter is odd
(defun Util-Odd? (number)
  "check a numer is odd or not?"
  ;; The REM function divides the first number on the second number and returns the reminder.
  (= (rem number 2) 1) 
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;retrieve the Entity Data;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 对已经获得的entryData的相关数据获得与key相关的数据或数组
(defun Util-GetDataByKey (key entryData)
(if (atom key)
    (cdr (assoc key entryData))
    (mapcar '(lambda (x) (cdr (assoc x entryData))) key)
    )
)

;; todo
;; entryData 是否包含有match的数据类型type的信息
;; match 可以是type元素也可以是多个list组成的list
(defun Util-GetEntType (edata match)
    (member (Util-GetDataByKey 0 edata) (if (listp match) match (list match)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; list



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; matrix
