(in-package :caad4lisp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wall package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; res: (line1Ename line2Ename angle )
(defun Wall-CreateByLines (line1 line2 / res)
  "Create a will by two lines."
  (setq res '())
  res
  )

(defun Wall-Flip (wall)
  "Flip this wall's direction."
  )

(defun Wall-CreateByPoints(pointList leftWidth rightWidth)
  "Create walls by points and width."
  )

(defun Wall-Intersected (wall1 wall2)
  "Trim intersected two walls"
  )
