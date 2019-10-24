;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;几何算法;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; todo autolispy有内置的 (angle pt1 pt2)
;; %i: (angle '(1.0 1.0) '(1.0 4.0))
;; %o: 1.5708
;; %i: (angle '(5.0 1.33) '(2.4 1.33))
;; %o: 3.14159
;; %i: (angle '(0 0) '(0 1))
;; %o: 1.57079633
;; %i: (angle '(0 1) '(0 0))
;; %o: 4.71238898
;;
;; 算斜度  pt1(x1 y1) pt2(x2 y2)   |(y1-y2)/(x1-x2)|
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
;; function: entmakex lwpolyline 
;; isClosed: 0 or 1  , 1=closed
(defun Geom-EntmakexPolyline (pointList isClosed / isClosedStatus)
  (setq isClosedStatus (cons 70 isClosed)) 
  (if (= Conf-AutoCAD-Version "2015+") 
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
            isClosedStatus
	      ) ;_  list
	      (mapcar '(lambda (x) (cons 10 x)) pointList)
	  ) ;_  append
    ))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; function: entmake lines
(defun Geom-EntmakeLines ( pointList / segmentList )
  (setq segmentList (mapcar
                     '(lambda (x y)
                       (cons x (list y))
                       )
                     (reverse (cdr (reverse pointList)))
                     (cdr pointList)
                     )
        )
  ;; (princ segmentList)
  (mapcar '(lambda(x)
            (entmake (list
                      '(0 . "LINE")
                      (cons 10 (car x))
                      (cons 11 (cdr x))
                      )
             )
            ;; (princ x)
            )
          segmentList )
  ) ;_ geom-entmakelines

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;retrieve the Entity Data;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
