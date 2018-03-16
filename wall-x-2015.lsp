;; 清理两道墙线相交之间的线(wall-x)
;; inters  获取两条线的交点
;; polar  Returns the UCS 3D point at a specified angle and distance from a point
;; minusp  Verifies that a number is negative 
;; ssname Returns the object (entity) name of the indexed element of a selection set
;; nth Returns the nth element of a list

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Start Of File
(defun c:wall-x (/ >90 @work dists edata etype fuzzy get getslope head i l0
		 merge neatx1 nukenz perp perps pt0 pt1 pt2 pt3 pt4 pt5 pt6
		 slope sort ss ssfunc tail wall1 wall2 walls work
		 )
  (setq clayer nil)
  ;; 设置检查输出 
  (princ "\nLoading -")
  (setq @WORK '("\\" "|" "/" "-"))
  (defun WORK ()
    ; Backspace
    (prompt "\010")
    (setq @work (append (cdr @work) (list (princ (car @work)))))
  )

  ;;;;;;;;;;;;;;;; 
  ;;断开交点  start
  (work)
  (defun NUKENZ (x)
    (cdr (reverse (cdr x)))
  )  
  (work)
  ; dist1为pt0到wall1两条线的距离
  ; dist2为pt0到wall2两条线的距离
  (defun NEATX1 (dist1 dist2)
    (cond
        ((cdr dist1)
            (work)
            (neatx2
                ; 1st wall - line 1
                (nth (cadar dist1) wall1)
                ; 1st wall - line 2
                (nth (cadr (last dist1)) wall1)
                ; 2nd wall - line 1
                (nth (cadar dist2) wall2)
                ; 2nd wall - line 2
                (nth (cadr (last dist2)) wall2)
            )
            (neatx1 (nukenz dist1) (nukenz dist2))
        )
        (T (princ "\rComplete."))
    )
  )
  (work)
  (defun NEATX2 (a1 a2 b1 b2)
    (mapcar
	'(lambda (x l1 l2)
	    (work)
	    (setq
            pt1 (cadr l1)
            pt2 (caddr l1)
            pt3 (cadr l2)
            pt4 (caddr l2)
	    )
     
	    (foreach
            l0
            x
            (setq
                pt5 (cadr l0)
                pt6 (caddr l0)
            )
            ; 断开线条
            (command
                ".BREAK" (car l0)
                (inters pt5 pt6 pt1 pt2)
                (inters pt5 pt6 pt3 pt4)
            )
	    )
	)
	(list (list a1 a2) (list b1 b2))
	(list b1 a1)
	(list b2 a2)
    )
  )
  ;;断开交点  end
  ;;;;;;;;;;;;;;

  
  (work)
  ;; 通过key查找关联数组
  (defun GET (key alist)
    (if (atom key)
	(cdr (assoc key alist))
	(mapcar '(lambda (x) (cdr (assoc x alist))) key)
	)
  )

  (work)
  ;; 判断x-y的绝对值是否无限小
  (defun FUZZY (x y)
     (< (abs (- x y)) 1.0e-6)
  ) 

  (work)
  ;; 对数组根据数字中第一个数字大小进行排序
  (defun SORT (x)
    (cond
      ((null (cdr x)) x)
      (T
	(merge
	    (sort (head x (1- (length x))))
	    (sort (tail x (1- (length x))))
	)
      )
    )
  )
  (work)
  ;; 合并数组并且按照第一个数组第一个数进行排序
  (defun MERGE (a b)
    (cond
         ((null a) b)
         ((null b) a)
         ((< (caar a) (caar b))
	    (cons (car a) (merge (cdr a) b))
	 )
	 (t (cons (car b) (merge a (cdr b))))
    )
  )
  (work)
  ;; 获取数组l中数字小于n的数
  (defun HEAD (l n)
    (cond
      ((minusp n) nil)
      (t (cons (car l) (head (cdr l) (- n 2))))
      )
   )
  (work)
  ;; 获取数组l中数字大于n的数
  (defun TAIL (l n)
    (cond
      ((minusp n) l)
      (t (tail (cdr l) (- n 2)))
      )
   )

  (work)
  ; 算斜度  pt1(x1 y1) pt2(x2 y2)   |(y1-2)/(x1-x2)|
  (defun GETSLOPE (pt1 pt2 / x)
    ; Vertical?
    (if (fuzzy (setq x (abs (- (car pt1) (car pt2)))) 0.0)
	; Yes, return NIL
	nil
	; No, compute slope
	(rtos (/ (abs (- (cadr pt1) (cadr pt2))) x) 2 4)
	)
  )
  
  (work)
  ;; edata:数组 是否包含有match的信息
  (defun ETYPE (edata match)
    (member (get 0 edata) (if (listp match) match (list match)))
  )
  (work)
  (defun SSFUNC (ss func / i ename)
    (setq i -1)
    (while (setq ename (ssname ss (setq i (1+ i))))
      (apply func nil)
      )
   )

  
  (work)
  ;; 求pt0到通过pt1及pt2的垂直点
  (defun PERP (pt0 pt1 pt2)
    (inters pt1 pt2 pt0 (polar pt0 (+ (angle pt1 pt2) >90) 1.0) nil)
  )

  
  ;---------------
  ; Main Function
  ;---------------
  (setq >90 (/ pi 2))
  ; Stuff Gary will want to fix...
  (setvar "CmdEcho" 0)
  (setvar "BlipMode" 0)
  (princ "\rLoaded. ")

  (while
    (progn
	(initget "Select")
	;; 获取第一点pt0
	(setq pt0 (getpoint "\nSelect objects/<First corner>: "))
    )
    (setq
	dists nil
	perps nil
	walls nil
    )

    (cond
      ((eq (type pt0) 'LIST)
	(initget 33)
	(setq
	    ;; 获取第二点pt1
	    pt1 (getcorner pt0 "\nOther corner: ")
	    ; 通过两点框选物体
	    ss (ssget "C" pt0 pt1)
	    )
      )
      (T
       (while
	   (progn
	     (princ "\nSelect objects: ")
	     (command ".SELECT" "Au" pause)
	     (not (setq ss (ssget "P")))
	     )
	 (print "No objects selected, try again.")
	 )
       (initget 1)
       (setq pt0 (getpoint "\nPoint to outside of wall: "))
       )
      )
    (princ "\nWorking ")
    (command ".UNDO" "Group")

    
    (ssfunc ss
	'(lambda ()
	    (work)
	    (setq edata (entget ename))
	    ; 如果是“LINE”者运行， 如果不是则下一个元素
	    ; 结果为walls数组(wall1 wall2)
	    ; wall1(slope edata1 edate2)
	    (if (etype edata "LINE")
		(setq
		    ; Get relevant groups
		    edata (get '(-1 10 11) edata)
		    slope (getslope (cadr edata) (caddr edata))
		    walls
		    ; Does this slope already exist in walls list
		    (if (setq temp (assoc slope walls))
			; Yes, add new line info to assoc group
			(subst (append temp (list edata)) temp walls)
			; Nope, add new assoc group w/line info
			(cons (cons slope (list edata)) walls)
		    )
		)
	    )
      )
    )

    (cond
        ((< (length walls) 2)
             (princ "\rerror: Use MEND to join colinear walls.")
        )
        ((> (length walls) 2)
            (princ "\rerror: Only two walls may be cleaned.")
        )
        ((not (apply '= (mapcar 'length walls)))
            (princ "\rerror: Walls have unequal number of lines.")
        )
	(T
	;------------------------------------
	; Create List of Perpendiculars(垂直线)
	; 获取pt0垂直与walls的垂直点（wall1-ps,wall2-ps）
	;------------------------------------
	    (setq perps
		(mapcar
		'(lambda (x)
			(work)
			(mapcar
			    '(lambda (y)
				(work)
				(perp pt0 (cadr y) (caddr y))
			    )
			    (cdr x)
			)
		    )
		    walls
		)
	    )
	    ;--------------------------
	    ; Create List of Distances
	    ; 获取pt0垂直与walls的垂直距离并对每道墙的墙线进行编号（wall1-dist,wall2-dist）
	    ; wall1-dist(wall1-dist1, wall1-dist2)
	    ;--------------------------
	    (setq dists
            (mapcar
                '(lambda (x)
                (work)
                (setq i 0)
                (mapcar
                    '(lambda (y)
                        (work)
                        ; Create list of distances (with pointers to WALLS)
                    (list
                        ; Compute distances
                        (distance pt0 y)
                        ; Key
                        (setq i (1+ i))
                     )
                    )
                    x
                )
                )
                ; List of perpendicular points
                perps
            )
	    )
	    ; Sort distance index
	    (setq dists (mapcar 'sort dists))
	    (setq wall1 (car walls) wall2 (cadr walls))
	    ; Clean intersections
	    (neatx1 (car dists) (cadr dists))
       )
    )
    (command ".UNDO" "End")
  )

  ;----------------------------
  ; Restore enviroment, memory
  ;----------------------------
  (princ)
)

(princ)
;; End Of File
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
