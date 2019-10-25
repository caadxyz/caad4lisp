;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; getpointlist
(defun getPointList (/ p1 p2 plist)
  (setq p1 (getpoint "\nSpecify first point: "))
  (setq plist (append plist (list p1)))

  (while (setq p2 (getpoint p1 "\nSpecify next point: " ))
    "grdraw: Draws a vector between two points, in the current viewport"
    (grdraw p1 p2 9)
    (setq plist (append plist (list p2)))
    (setq p1 p2)
  )
  plist
)



(setq l1 '((121.02304632 1) (171.02304632 2)))
(setq l2 '((102.55026166 1) (52.55026166 2)))

(defun sort (l)
(if (< (caar l) (caar (cdr l)) )
    l  
    (reverse l)
)

