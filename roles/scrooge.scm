(define-module (roles scrooge)
  #:use-module (profiles basic-workstation)
  #:use-module (profiles development-workstation)
  #:use-module (profiles 3d-printing-workstation))

(define-public scrooge-packages
  (append
   basic-workstation-packages
   development-workstation-packages
   3d-printing-workstation-packages))
