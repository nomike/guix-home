(define-module (modules 3d-printing)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix transformations))


(define-public 3d-printing-packages
  (append
    (specifications->packages
      (list
        "meshlab" ; 3D triangular mesh processing and editing software
        "openscad" ; Script-based 3D modeling app
        "prusa-slicer"  ; G-code generator for 3D printers (RepRap, Makerbot, Ultimaker etc.)
        "pythonscad" ; Script-based 3D modeling app whith Python suppo
       ))))
