(define-module (modules programming)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix transformations)
  #:export (programming-packages)
  )

(define-public programming-packages
  (append 
   (specifications->packages
    (list
     "tree-sitter-scheme" ; tree-sitter Scheme (R5RS, R6RS) grammar
     "tree-sitter-python" ; Tree-sitter Python grammar
     "tree-sitter-bash" ; Tree-sitter Bash grammar
     "tree-sitter-org" ; Tree-sitter Org grammar
     ))))
