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

;; function of entmake lwpolyline 
;; isClosed: 0 or 1  , 1=closed
(defun Geom-Entmakepolyline (pointList isClosed / conf-isClosed)
  (setq conf-isClosed (cons 70 isClosed)) 
  (if (= Conf-AutoCAD-Version 2015) 
    (entmakex 
      (append
          (list '(0 . "LWPOLYLINE") '(100 . "AcDbEntity") '(100 . "AcDbPolyline")
		    (cons 90 (length pointList)) 
            conf-isClosed
	      ) ;_  list
	      (mapcar '(lambda (x) (cons 10 x)) pointList)
	  ) ;_  append
    )
    (entmakex 
      (append
          (list '(0 . "LWPOLYLINE")
		    (cons 90 (length pointList)) 
            conf-isClosed
	      ) ;_  list
	      (mapcar '(lambda (x) (cons 10 x)) pointList)
	  ) ;_  append
    ))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;retrieve the Entity Data;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
