(define-module (profiles basic-workstation)
  #:use-module (modules basic-shell-tools)
  #:use-module (modules emacs)
  #:export (basic-workstation-packages))

(define-public basic-workstation-packages
  (append
   basic-shell-tools-packages
   emacs-packages
   )
  )
