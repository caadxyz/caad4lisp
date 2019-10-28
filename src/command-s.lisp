;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; autolisp command compatibility
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;; BREAK
(defun Command-Break(entity p0 p1 )
  (if (= Conf-AutoCAD-Version "2015+" )
      (command-s ".BREAK" entity "F" p0 p1 )
      (command   ".BREAK" entity  p0 p1 )
      )
  )


