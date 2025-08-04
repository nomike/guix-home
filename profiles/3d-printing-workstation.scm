(define-module (profiles 3d-printing-workstation)
  #:use-module (modules basic-shell-tools)
  #:use-module (modules emacs)
  #:use-module (modules 3d-printing)
  #:use-module (modules version-control))

(define-public 3d-printing-workstation-packages
  (append
   basic-shell-tools-packages
   3d-printing-packages
   version-control-packages))
