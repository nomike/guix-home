(define-module (home-config)
  #:use-module (gnu home)
  #:use-module (gnu packages version-control)
  #:use-module (gnu services)
  #:use-module (emacs-packages)); This imports the emp module

(home-environment
  (packages (append
      emacs-packages ; Note: just 'emp', not '(emp)' since it's a list, not a function
      (list
        ;; You can add other packages here
        ))))
