;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;               General autolisp utility                       ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :caad4lisp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; General Mathod & language
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; debug程序加载进程情况
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

(defun Util-Functionp (v)
  "function?"
  (or (member (type v) '(SUBR USUBR)))
  )

(defun Util-Symbolp (v)
  "symbol?"
  (= (type v) 'SYM)
  )

;;;;;;;;;
;;;; Math
;;;;;;;;;

;; A real number defining the maximum amount by which expr1 and expr2 can differ
;; and still be considered equal.
(setq Util-Math-Fuzz 1.0e-6)

;; Parameters:
;; number: int
;; Return
;; bool: True, if the parameter is odd
(defun Util-Math-Odd? (number)
  "check a numer is odd or not?"
  ;; The REM function divides the first number on the second number and returns the reminder.
  (= (rem number 2) 1) 
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; retrieve the Entity Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; todo edata or ename
;; 对已经获得的entryData的相关数据获得与key相关的数据或数组
;; parameter:
;; key: element or list, 10 or '(-1 0 10 11)
(defun Util-Data-GetDataByKey (key eData)
    "Get related element or list from entity data by a key"
    (if (atom key)
        (cdr (assoc key eData))
        (mapcar '(lambda (x)
                  (cdr (assoc x eData)))
                key)
        )
)

;; todo edata or ename
;; entityData 是否包含有match的数据类型type的信息
;; match 可以是type元素也可以是多个list组成的list
(defun Util-Data-GetEntType (edata match)
    "Check this entity data's type is the matching element or 
    is  included in the matching list "
    (or (member
         (Util-Data-GetDataByKey 0 edata)
         (if (listp match) match (list match)))
        )
)


;;;;;;;;;;;;;;;;;
;;; matrix
;;;;;;;;;;;;;;;;;


(princ "Util.lisp loaded")
(princ)
