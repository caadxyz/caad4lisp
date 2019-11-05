;; under working
;; (setq x 10);
;; (eval-macro 'x)
(defun eval-macro( v / b  process)
 "macro代码,其中b为内部参数"
 (setq process '(progn 
    "macro start"
    (setq b 1) 
    "macro end"
 ))
 "用外部参数v替换掉内部参数b"
 (setq process (mapcar 
    "需要修改lambda的代码，进行递归替换掉所有的参数"
    '(lambda (x) 
       (if (listp x)
            (subst v 'b x)
            x ) 
       )
     process)
 )
 (princ "\n---source code---\n")
 (princ process)
 (princ "\n---result---\n")
 (eval process)
 (princ)
 )
