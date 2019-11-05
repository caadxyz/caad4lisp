(defpackage caad4lisp
  (:use :cl)
  (:export

    #:Util-Working
    #:Util-Functionp
    #:Util-Symbolp
    #:Util-Math-Odd?
    #:Util-Data-GetDataByKey
    #:Util-Data-GetEntType

    #:Geom-X
    #:Geom-Y
    #:Geom-Z
    #:Geom-Line-MakeStruct
    #:Geom-Line-Flip
    #:Geom-Line-GetParamAtIntersection
    #:Geom-Line-GetParamAtPoint
    #:Geom-Line-GetPointAtParam
    #:Geom-Line-IsPointOnLine
    #:Geom-Line-GetLineAngle
    
    #:Wall-CreateByEntLines
    #:Wall-CreateByPoints
    #:Wall-Flip
    #:Wall-Intersected

    )
) ;_ defpackage


