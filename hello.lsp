;AUTOLISP CODING STARTS HERE
(prompt "\nType HellO to run...")

(defun C:HELLO ()

(setq dcl_id (load_dialog "hello.dcl"))

     (if (not (new_dialog "hello" dcl_id))
	 (exit )
     );if

(action_tile "accept"
    "(done_dialog)"
);action_tile

(start_dialog)
(unload_dialog dcl_id)

(princ)

);defun
(princ)
;AUTOLISP CODING ENDS HERE
