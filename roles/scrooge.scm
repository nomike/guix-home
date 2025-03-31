(define-module (roles scrooge)
  #:use-module (profiles basic-workstation)
  #:export (scrooge-packages))

(define-public scrooge-packages
  (append
    basic-workstation-packages
  )
)
