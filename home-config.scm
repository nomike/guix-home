(define-module (home-config)
  #:use-module (gnu home)
  #:use-module (gnu packages engineering)
  #:use-module (gnu packages version-control)
  #:use-module (gnu services)
  #:use-module (emacs-packages))

(home-environment
  (packages (append
      emacs-packages ; Note: just 'emp', not '(emp)' since it's a list, not a function
      (list
        openscad
        ))))
