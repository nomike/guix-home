(define-module (home-config)
  #:use-module (gnu home)
  #:use-module (gnu packages base)
  #:use-module (roles scrooge)
  #:use-module (modules zsh))


(home-environment
  (packages
    (append
      scrooge-packages
      (list)))
  ; (services
  ;  (list
  ;   zsh-service))
  )
