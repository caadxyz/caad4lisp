;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; defmacro for autolisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;; The Roots of Lisp
;;;; Paul Graham
;;;; English: http://www.paulgraham.com/rootsoflisp.html
;; (pair. x y) takes two lists of the same length and returns a list of
;; two element lists containing successive pairs of an element from each.
;; > (pair. '(x y z) '(a b c))
;; ((x a) (y b) (z c))
(defun Util-Pair (x y)
  (cond ((and (null. x) (null y)) '())
        ((and (not (atom x)) (not (atom y)))
         (cons (list (car x) (car y))
               (Util-Pair (cdr x) (cdr y))))))

;; (assoc. x y ) takes an atom x and a list y of the form created by pair.,
;; and returns the second element of the first list in y whose first element is x.
;; > (assoc. 'x '((x a) (y b)))
;; a
;; > (assoc. 'x '((x new) (x a) (y b)))
;; new
(defun Util-Assoc (x y)
  (cond ((eq (caar y) x) (cadar y))
        ('t (Util-Assoc x (cdr y)))))

;; macro
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

;; dotimes
;; (Util-Dotimes (i 3) (print i) )
(defun Util-Dotimes(outCode0 outCode1 /  vOut vIn macroCode)
  (setq vOut (list (car outCode0) (cadr outCode0) outCode1)) 
  (setq vIn '(count length code))
  (setq macroCode
        '(progn (setq count 0)
          (while (< count length)
            code
            (setq count (1+ count))
            )
          )
        )
   (princ (Util-Macro vOut vIn macroCode))    
  )
