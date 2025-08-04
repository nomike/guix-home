(define-module (profiles basic-workstation)
  #:use-module (modules basic-shell-tools)
  #:use-module (modules emacs)
  #:use-module (modules version-control))

(define-public basic-workstation-packages
  (append
   basic-shell-tools-packages
   emacs-packages
   version-control-packages))
