(define-module (modules gui-tools)
  #:use-module (gnu packages))

(define-public gui-packages
  (specifications->packages
   (list
    "firefox"                 ; Web browser
    "icedove")))          ; Thunderbird email client
