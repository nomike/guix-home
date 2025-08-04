(define-module (modules version-control)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix transformations))

(define-public version-control-packages
  (append
   (specifications->packages
    (list
     "codeberg-cli" ; CLI Tool for codeberg similar to gh and glab
     ))))
