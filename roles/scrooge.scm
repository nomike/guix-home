(define-module (roles scrooge)
  #:use-module (profiles basic-workstation)
  #:use-module (profiles developer-workstation)
  #:export (scrooge-packages))

(define-public scrooge-packages
  (append
     basic-workstation-packages
    ;; developer-workstation-packages
  )
)
