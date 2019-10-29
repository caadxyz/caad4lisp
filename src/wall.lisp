(in-package :caad4lisp)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;                                                              ;;;;
;;;;                    wall tools                                ;;;;
;;;;                                                              ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;; todo test
;;;; return: (list (list  line0Ename line0 ) (list line1Ename line1) angle )
(defun Wall-CreateByEntLines (entLine0 entLine1 / line0 line1  angle0 angle1 )
  "Create a wall by two lines."
  (setq line0 (Util-Data-GetDataByKey '(10 11) (entget entLine0) ))
  (setq line1 (Util-Data-GetDataByKey '(10 11) (entget entLine1) ))
  (setq angle0 (Geom-Line-GetLineAngle) line0)
  (setq angle1 (Geom-Line-GetLineAngle) line1)
  (cond
    ((equal (abs (- angle0 angle1)) 0.0 Util-Math-Fuzz)
     (list (append entLine0 line0) (append entLine1 line1)  angle0)
     )
    ((equal (abs (- angle0 angle1)) pi  Util-Math-Fuzz)
     (Geom-EntLine-Flip entLine1)
     (list (append entLine0 line0) (append entLine1 line1)  angle0)
     )
    (t  nil )
    )
  )

;;;; todo: underwork
(defun Wall-Flip (wall / wline0 wline1)
  "Flip this wall's direction."
  )

(defun Wall-CreateByPoints(pointList leftWidth rightWidth)
  "Create walls by points and width."
  )

(defun Wall-Intersected (wall1 wall2)
  "Trim intersected two walls"
  )
