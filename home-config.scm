(define-module (home-config)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (emacs-packages))

(home-environment
  (packages
    (append
        emacs-packages
    )
  )
)
