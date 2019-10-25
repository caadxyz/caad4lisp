;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wall package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; res: (line1 line2 angle )
(defun wall (line1 line2 / res)
  (setq res '())
  res
  )

;; flip this wall's direction 
(defun wall-flip (w)
  )

;; 需要判断角度，距离可以为负值，表示反方向
(defun wall-distance2point (w point / wl1dist wl2dist )
  (setq wl1dist  nil)
  (setq wl2dist  nil)
  )

(defun wall-draw(w)
  nil
  )


(defun wall-list-draw (pointList)
  nil
  )

(defun wall-intersected (w1 w2)
  nil
  )
