;; provide defmacro for autolisp
(defun Util-Macro (vOut vIn code / vOutList vInList)
    (setq vOutList (if (listp vOut) vOut (list vOut))) 
    (setq vInList (if (listp vIn) vOut (list vIn))) 
    (mapcar
         '(lambda (x)
           (cond
             ((not (listp x) )
              ;; need a functon for assoc-vOut from book <lisp of root>
              (if (member x vInList) assoc-vOut x )
              )
             (t (Util-Macro vOut vIn x))
             )
           )
         code 
         )
    )
;; example of how to use macro
;; (setq x 5)
;; (setq Util-Macro-Y
;;     "macro start"
;;     "vIn: y"
;;     '(y
;;     (+ y 3 (+ y 3 (+ y 4)))
;;     )
;;     "macro end"
;; )
;; (util-macro-Example 'x Util-Macro-Y) 
(defun Util-Macro-Example (vOut macroCode / vIn code )
    (setq vIn (car macro-code))
    (setq code (cadr macro-code))
    ;;(princ (func vOut vIn code))     
    (eval (Util-Macro vOut vIn code))    
  )
;; (Util-Dolist('i '(a b c) '(print i) )
(defun Util-Dolist (outIndex outList outCode / vOut vIn macroCode)
   (setq vOut '(outIndex  outList outCode)) 
   (setq vIn '(x inList code))
   (setq macroCode '(mapcar (quote (lambda (x) code)) inList) ) 
   (princ (Util-Macro vOut vIn macroCode))    
  )
