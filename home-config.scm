(define-module (home-config)
  #:use-module (gnu home)
  #:use-module (gnu packages base)
  #:use-module (packages pythonscad)
  #:use-module (roles scrooge)
  )


(home-environment
 (packages
  (append
   scrooge-packages
   (list
   pythonscad)
   )
  )
 )
