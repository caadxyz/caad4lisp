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
