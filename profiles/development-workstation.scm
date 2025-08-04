(define-module (profiles development-workstation)
  #:use-module (modules basic-shell-tools)
  #:use-module (modules emacs)
  #:use-module (modules programming)
  #:use-module (modules version-control))

(define-public development-workstation-packages
  (append
   basic-shell-tools-packages
   emacs-packages
   version-control-packages
   programming-packages
   )
  )
