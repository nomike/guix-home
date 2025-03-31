(define-module (profiles basic-workstation)
  #:use-module (modules emacs)
  #:export (basic-workstation-packages))

(define-public basic-workstation-packages
  (append
    emacs-packages
  )
)
