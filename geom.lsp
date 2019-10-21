;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;几何算法;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 算斜度  pt1(x1 y1) pt2(x2 y2)   |(y1-y2)/(x1-x2)|
(defun Geom-GetSlope (pt1 pt2 / x)
    ; Vertical?
    (if (equal (setq x (abs (- (car pt1) (car pt2)))) 0.0 Util-Fuzz)
        ; Yes, return NIL
        nil
        ; No, compute slope
        ; Converts a number into a string
        ; (rtos number [mode [precision]])
        (rtos (/ (abs (- (cadr pt1) (cadr pt2))) x) 2 4)
    )
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;retrieve the Entity Data;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
