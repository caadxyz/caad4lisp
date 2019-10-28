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

(defun sort (lst)
  (if (< (caar lst) (caar (cdr lst) ) )
     lst 
     (reverse lst)
  )
)


;;; http://bbs.mjtd.com/thread-178359-1-1.html  
(princ "\U+6D4B\U+8BD5")

(princ "马海东" )
(princ "还是马海东")
;; (princ "abc")
