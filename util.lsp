; A real number defining the maximum amount by which expr1 and expr2 can differ and still be considered equal.
(setq Util-Fuzz 1.0e-6)

;; debug程序加载进程情况;;;
(setq @Util-Working '("\\" "|" "/" "-"))
(defun Util-Working ()
    ; Backspace
    (prompt "\010")
    (setq @Util-Working (append (cdr @Util-Working) (list (princ (car @Util-Working)))))
)
