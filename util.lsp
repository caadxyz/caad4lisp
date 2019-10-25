;; A real number defining the maximum amount by which expr1 and expr2 can differ
;; and still be considered equal.
(setq Util-Fuzz 1.0e-6)

;; debug程序加载进程情况
(setq @Util-Working
      '("\\" "|" "/" "-"))
(defun Util-Working ()
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

(defun Util-IsOdd (number)
  ;; The REM function divides the first number on the second number and returns the reminder.
  ;; 判断number是否是奇数
  (= (rem number 2) 1) 
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;retrieve the Entity Data;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 对已经获得的entryData的相关数据获得与key相关的数据或数组
;; ( (-1 . <EName:  00006000035819e0>) 
;;   (0 . LINE) (5 . 173)  
;;   (330 . <EName:  000060000371b5d0>)  
;;   (100 . AcDbEntity) 
;;   (67 . 0)  
;;   (410 . Model)  
;;   (8 . 0) 
;;   (100 . AcDbLine)  
;;   (10 -24.8581413 -12.28693165 0.0) 
;;   (11 137.81192438 79.25036151 0.0) 
;;   (210 0.0 0.0 1.0)
;; )
(defun Util-GetDataByKey (key entryData)
(if (atom key)
    (cdr (assoc key entryData))
    (mapcar '(lambda (x) (cdr (assoc x entryData))) key)
    )
)


;; entryData 是否包含有match的数据类型type的信息
;; match 可以是type元素也可以是多个list组成的list
(defun etype (entryData match)
    (member (Util-GetDataByKey 0 edata) (if (listp match) match (list match)))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; list



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; matrix
