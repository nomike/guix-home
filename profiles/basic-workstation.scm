(define-module (profiles basic-workstation)
  #:use-module (modules emacs)
  #:use-module (modules basic-shell-tools)
  #:export (basic-workstation-packages))

(define-public basic-workstation-packages
  (append
    emacs-packages
    basic-shell-tools-packages
  )
)
