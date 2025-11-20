(define-module (modules programming)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix transformations))

(define-public programming-packages
  (append
   (specifications->packages
    (list
     "cppcheck" ; "Static C/C++ code analyzer"
     "cloc" ; Count source lines of code (SLOC) and other source code metrics
     "just" ; Command runner
     "tree-sitter-scheme" ; tree-sitter Scheme (R5RS, R6RS) grammar
     "tree-sitter-python" ; Tree-sitter Python grammar
     "tree-sitter-bash" ; Tree-sitter Bash grammar
     "tree-sitter-org" ; Tree-sitter Org grammar
     "uncrustify" ; Code formatter for C and other related languages
     "valgrind" ; Debugging and profiling tool suite
     ))))
