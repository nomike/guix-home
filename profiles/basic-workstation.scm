(define-module (profiles basic-workstation)
  #:use-module (modules basic-shell-tools)
  #:use-module (modules emacs)
  #:use-module (modules programming) ;; TODO: Move to developer-workstation once the issue is fixed
  #:export (basic-workstation-packages))

(define-public basic-workstation-packages
  (append
   basic-shell-tools-packages
   emacs-packages
   progamming ;; TODO: Move to developer-workstation once the issue is fixed
   )
  )
