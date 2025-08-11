(define-module (modules 3d-printing)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix transformations))


(define-public 3d-printing-packages
  (append
   (specifications->packages
    (list
     "pythonscad"    ; Script-based 3D modeling app whith Python suppo
     "prusa-slicer"  ; G-code generator for 3D printers (RepRap, Makerbot, Ultimaker etc.)
     ))))
