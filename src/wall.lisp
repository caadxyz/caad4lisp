;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                    wall tools                                ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :caad4lisp)

;; data: wallStruct
;; (list 
;;    (lineStruct0) 
;;    (lineStruct1) 
;;    angle 
;; )
;; private
(defun Wall-makeStruct(lineStruct0 lineStruct1 angle)
 (list lineStruct0 lineStruct1 angle )
)

;; todo underwork
;; return:  wallStruct
(defun Wall-CreateByEntLines (entLine0 entLine1 / line0 line1  angle0 angle1 )
  "Create a wall by two lines."
  (setq line0 (Util-Data-GetDataByKey '(10 11) (entget entLine0) ))
  (setq line1 (Util-Data-GetDataByKey '(10 11) (entget entLine1) ))
  (setq angle0 (Geom-Line-GetLineAngle) line0)
  (setq angle1 (Geom-Line-GetLineAngle) line1)
  (cond
    ((equal (abs (- angle0 angle1)) 0.0 Util-Math-Fuzz)
     (Wall-makeStruct entLine0 line0 entLine1 line1)
     )
    ((equal (abs (- angle0 angle1)) pi  Util-Math-Fuzz)
     (Geom-EntLine-Flip entLine1)
     (Wall-makeStruct entLine0 line0 entLine1 line1)
     )
    (t  nil )
    )
  )

;; todo: underwork
(defun Wall-Flip (wallStruct / wEntLine0 wEntLine1)
    "Flip this wall's direction."
  )

(defun Wall-CreateByPoints(pointList leftWidth rightWidth)
  "Create walls by points and width."
  )

(defun Wall-Intersected (wall1 wall2)
  "Trim intersected two walls"
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; w1: width1
;; w2: width2
;; plist: (p1 p2 p3 ...)
;; anglist:
;; seglist: ((p1 p2) (p2 p3) ...)
;; seg1list: ( w1seglist1  w1seglist2 ...)
;; seg2list: ( w2seglist1  w2seglist2 ...)
(defun C:Wall-Dline (/ w1 w2 plist anglist seglist seg1list seg2list
                wall-grdraw getpointlist segxlist intlst
)

  "set the wall width"
  (setq w1  10 w2  20)

  "temp wall-grdraw"
  (defun wall-grdraw (p1 p2 w1 w2 / ang)
    (setq ang (angle p1 p2))
    (grdraw (polar p1 (+ ang (* pi 0.5)) w1 )
            (polar p2 (+ ang (* pi 0.5)) w1) 251
            )
    (grdraw (polar p1 (+ ang (* pi 1.5)) w2) 
            (polar p2 (+ ang (* pi 1.5)) w2) 251
            )
    )

  "getpointlist"  
  (defun getpointlist (w1 w2 / plist  p1 p2)
    (setq p1 (getpoint "\nSpecify first point: " ))
    (setq plist (append plist (list p1)))
    (while (setq p2 (getpoint p1 "\nSpecify next point: " ))
      ;; grdraw: Draws a vector between two points, in the current viewport
      ;; (grdraw p1 p2 9)
      (wall-grdraw p1 p2 w1 w2)
      (setq plist (append plist (list p2)))
      (setq p1 p2)
      )
    plist
    )

  "to get the offset segment of two side line"
  (defun segxlist (seglist anglist direction width / res  xa xb x1a x1b)
    (setq i 0)
    (if (= direction 1)
        (setq ang (* pi 0.5))
        (setq ang (* pi 1.5))
        )
    (foreach x seglist
             (setq xa (car x)
                   xb (cadr x)
                   )
             (setq x1a (polar xa (+ ang (nth i anglist)) width))
             (setq x1b (polar xb (+ ang (nth i anglist)) width))
             (setq res (append
                        res
                        (list x1a x1b)
                        )
                   )
             (setq i (1+ i))
             )
    res
    )

  "find the intersections of a list of points"
  (defun intlst (lst / i res p1 p2 p3 p4)
    (setq i 0)
    (setq res (list (car lst)))
    (repeat (- (/ (length lst) 2) 1)
            (setq p1 (nth i lst))
            (setq i (1+ i))
            (setq p2 (nth i lst))
            (setq i (1+ i))
            (setq p3 (nth i lst))
            (setq p4 (nth (1+ i) lst))
            (setq res (append
                       res
                       (list (inters p1 p2 p3 p4 nil))
                       )
                  )
            )
    (setq res (append
               res
               (list (last lst))
               )
          )
    res
    )

  "main function start"
  (setq plist (getpointlist w1 w2))
  ;; (princ "\n----plist-----\n")
  ;; (princ plist)
  
  (setq anglist (mapcar
                 '(lambda (x y)
                   (angle x y)
                   )
                 (reverse (cdr (reverse plist)))
                 (cdr plist)
                 )
        )
  ;; (princ "\n----anglist-----\n")
  ;; (princ anglist)
  
  (setq seglist (mapcar
                 '(lambda (x y)
                   (cons x (list y))
                   )
                 (reverse (cdr (reverse plist)))
                 (cdr plist)
                 )
        )
  ;; (princ "\n----seglist-----\n")
  ;; (princ seglist)
  (setq seg1list (segxlist seglist anglist  1 w1))
  (setq seg2list (segxlist seglist anglist -1 w2))
  ;; (Geom-EntmakexPolyline (intlst seg1list) 0)
  ;; (Geom-EntmakexPolyline (intlst seg2list) 0)
  (Geom-EntmakeLines (intlst seg1list) )
  (Geom-EntmakeLines (intlst seg2list) )
  "main function end"
) 

