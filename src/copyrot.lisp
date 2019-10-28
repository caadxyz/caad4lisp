(in-package :caad4lisp)

;************************************************************
;COPYROT.LSP               
;Copies selected objects and rotates them in their new 
;************************************************************

; Let's define our main function 'cr' and local vars
(defun c:cr (/ sel pt)
        (setq ent 1) ; set ent var to 1 for loop

        ; Ask user for selection
        (while (= sel nil) 
            ; wait for selection 
            (princ "\nSelect objects to copyrot:")
            (setq sel (ssget))
        )

        ; Copy selected objects on their own position
        (command "_.COPY" sel "" "0,0" "@")

        ; Let's move selected opjects
        (princ "\Please select base point:")
        (setq pt (getpoint))
        (princ "\Select second point:")
        ; pause waits user for pick second point
        (command "_.MOVE" "_P" "" pt pause)
        ; let's rotate copied objects on their new position
        ; first get LASTPOINT value as rotation base point
        (setq pt (getvar "LASTPOINT"))
        (princ "\nPlease enter rotation angle:")
        (command "_.ROTATE" "_P" "" pt pause)

)

(princ "\n  COPYROT loaded.")
(princ)




