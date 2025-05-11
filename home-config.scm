(define-module (home-config)
  #:use-module (gnu home)
  #:use-module (gnu packages base)
  #:use-module (roles scrooge)
  )


(home-environment
 (packages
  (append
   scrooge-packages
   )
  )
 )
