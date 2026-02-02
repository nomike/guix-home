(define-module (modules 3d-printing)
  #:use-module (gnu packages)
  #:use-module (packages prusa-slicer))
(define-public 3d-printing-packages
  (append
    (specifications->packages
      (list
        ; "meshlab" ; 3D triangular mesh processing and editing software
        "openscad" ; Script-based 3D modeling app
        ; "prusa-slicer"  ; G-code generator for 3D printers (RepRap, Makerbot, Ultimaker etc.)
        ; "pythonscad" ; Script-based 3D modeling app with Python support
       ))
    (list
      prusa-slicer)))
