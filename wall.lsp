;;;=============================================
;;; Most of the following codes are writen by  ;
;;; CHEN QING JUN                              ;
;;; Civil engineering Department,              ;
;;; South China University of Technology       ;
;;; http://autolisper.googlepages.com          ;
;;; http://qjchen.googlepages.com              ;
;;; Purpose:Draw different width double line   ;
;;; 2006.07.02                                 ;
;;; Version:0.1                                ;
;;; ============================================

;;; Main function
;;; require autocad

(defun c:wall (/ p1 plist w1 w1a w2 w2a w1lst w2lst anglist seglist 
seg1list seg2list)
 (setq w1 10
	w1a 10
	w2 20
	w2a 20
  )
  (setq w1lst (makew w1 w1a 100))
  (setq w2lst (makew w2 w2a 100))
  (setq plist (getpointlst w1lst w2lst))
  (setq anglist (mapcar
		  '(lambda (x y)
		     (angle x y)
		   )
		  (1ton_1 plist)
		  (cdr plist)
		)
  )
  (setq seglist (mapcar
		  '(lambda (x y)
		     (cons x (list y))
		   )
		  (1ton_1 plist)
		  (cdr plist)
		)
  )
  (setq w1lst (makew w1 w1a (length seglist)))
  (setq w2lst (makew w2 w2a (length seglist)))
  (setq seg1list (segxlist seglist anglist 1 w1lst))
  (setq seg2list (segxlist seglist anglist (- 1) w2lst))
  (setq seg1list (intlst seg1list))
  (setq seg2list (intlst seg2list))
  (entmakepolyline seg1list)
  (entmakepolyline seg2list)
)
;;;getpointlist
(defun getpointlst (w1lst w2lst / plist p1 p i)
  (setq p1 (getpoint))
  (setq plist (append
		plist
		(list p1)
	      )
  )
  (setq i 0)
  (while (setq p (getpoint p1))
    (grdraw p1 p 9)
    (tempgrdraw p1 p i w1lst w2lst)
    (setq plist (append
		  plist
		  (list p)
		)
    )
    (setq p1 p)
    (setq i (1+ i))
  )
  plist
)
;;;tempdraw
(defun tempgrdraw (p1 p2 n lst1 lst2 / ang)
  (setq ang (angle p1 p2))
  (grdraw (polar p1 (+ ang (* pi 0.5)) (1- (nth (* n 2) lst1)))
	  (polar p2 (+ ang (* pi 0.5)) (1- (nth (1+ (* n 2)) lst1))) 251
  )
  (grdraw (polar p1 (+ ang (* pi 1.5)) (1- (nth (* n 2) lst2))) 
          (polar p2 (+ ang (* pi 1.5)) (1- (nth (1+ (* n 2)) lst2))) 251
  )
)

;; get the 1 to (n-1) element of a list
(defun 1ton_1 (lst)
  (reverse (cdr (reverse lst)))
)
;;;to get the offset segment of two side line
(defun segxlist (lst lst1 direction wlst / i res xa xb x1a x1b)
  (setq i 0)
  (if (= direction 1)
    (setq ang (* pi 0.5))
    (setq ang (* pi 1.5))
  )
  (foreach x lst
    (setq xa (car x)
	  xb (cadr x)
    )
    (setq x1a (polar xa (+ ang (nth i lst1)) (nth (* i 2) wlst)))
    (setq x1b (polar xb (+ ang (nth i lst1)) (nth (1+ (* i 2)) wlst)))
    (setq res (append
		res
		(list x1a x1b)
	      )
    )
    (setq i (1+ i))
  )
  res
)
;;;;find the inter intersections of a list of points
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
		(list (inter p1 p2 p3 p4))
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
(defun inter (a b c d / res)
  (if (equal b c)
    b
    (inters
      a
      b
      c
      d
      nil
    )
  )
)
;;;function of entmake lwpolyline,by ElpanovEvgeniy at 
;www.theswamp.org
(defun entmakepolyline (lst)
  (entmakex (append
	      (list '(0 . "LWPOLYLINE") '(100 . "AcDbEntity") '(100 . 

"AcDbPolyline")
		    (cons 90 (length lst)) '(70 . 0) ;;;1 is closed
	      ) ;_  list
	      (mapcar '(lambda (x)
		   (cons 10 x)
		 )
		lst
	      )
	    ) ;_  append
  )
)
;;;;make width list
(defun makew (w1 w2 n / res i)
  (setq i 1)
  (repeat n
    (if (odd i)
      (setq res (append
		  res
		  (list w1 w2)
		)
      )
      (setq res (append
		  res
		  (list w2 w1)
		)
      )
    )
    (setq i (1+ i))
  )
  res
)
;;;judge whether a number is an odd number
(defun odd (x)
  (/= (/ x 2) (* 0.5 x))
)
