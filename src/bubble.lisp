(in-package :caad4lisp)

;***************************************************************
; BUBBLE.LSP
;***************************************************************
; Draws a bubble at the end of axes
;***************************************************************


; Let's define the variables.
; store the old env, after this command we can restore the env.
(setq
     oldCmdecho (getvar "cmdecho")  ; get cmdecho state
     oldLayer   (getvar "clayer")    ; get current layer
)

;Let's define the command
(defun c:bubble()
    (setq cap (getdist "\nEnter bubble diameter:"))

    (setvar "cmdecho" 1)

    ;Change the LAYEr and close command echo
    (command "_.layer" "_new" "TAL_BUBBLE" "_set" "TAL_BUBBLE" "")

    (draw_bubble)
    (setvar "cmdecho" oldCmdecho)
    (setvar "clayer"  oldLayer)
    (princ "\n one bubble added")
    (princ)
)

; Bublle draw function
(defun draw_bubble (/ aks pp aks_hand acd_en bh aks_pt1 aks_pt2 aks_ang dist1 dist2 circlecenter)

    ;Let's select the end of the axis where we will place the bubble
    ;and the selection point.
    (setq  
        aks (entsel "\nSelect the axis line:")
        pp (cadr aks)    ; Selection point (PICKPOINT)
        aks_hand (entget (car aks))  ; List of axis member
        acd_en (cdr (assoc 0 aks_hand)) ; Name of the selected entity
    )

    ;If the selected entity is not LINE, then exit the program
    (if (/= acd_en "LINE")
        (progn
            (princ "\nSelected entity is not LINE!")
            (quit)
        )
        (princ)
    )  

    ;Now, let's ask the other questions
    (setq bh (getstring "\nEnter bubble label:"))

    ;Let's make the calculations
    ;Calculate the start and end points of axis
    (setq  
        aks_pt1 (cdr (assoc 10 aks_hand))
        aks_pt2 (cdr (assoc 11 aks_hand))
    )

    ;Let's calculate the angle of axis
    ;(by using deg2rad function)
    (setq aks_ang (angle aks_pt1 aks_pt2))

    ;Let's find which end of axis the selection
    ;point is more close to
    (setq  
        dist1 (distance pp aks_pt1)
        dist2 (distance pp aks_pt2)
    )

    ;Now make the drawing calculations
    ;If the selection point is close to starting point
    (if (< dist1 dist2) 
        (setq circlecenter (polar aks_pt1 (+ pi aks_ang) (/ cap 2.0)))
        (setq circlecenter (polar aks_pt2 aks_ang (/ cap 2.0)))
    )

    ;Draw bubble
    (command "_.circle" circlecenter (/ cap 2.0))
    (princ "\ndraw a circle")
    ;Write its text
    (command "._text" "_j" "_middle" circlecenter (* cap 0.6) 0 bh ) 
    (princ "\nwrite its text")

)

;finished drawing
(princ "\n  BUBBLE loaded.")
(princ)
