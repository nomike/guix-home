(define-module (packages python-awscli)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu home)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system python)
  #:use-module (guix build-system pyproject)
  #:use-module (gnu packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix transformations)
  #:use-module (guix build-system qt)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (python-awscli))

;(define-public python-awscli
;  (package
;    (name "python-awscli")
;    (version "1.40.20")
;    (source
;     (origin
;       (method url-fetch)
;       (uri (pypi-uri "awscli" version))
;       (sha256
;        (base32 "0vbhy8p8gqjxc1qf3bmrk2zb3n8i0b3h458bmx3dx72sxjf9812v"))))
;    (build-system pyproject-build-system)
;    (native-inputs (list python-pip python-setuptools python-wheel nss-certs))
;    (propagated-inputs (list python-botocore
;                             python-colorama
;                             python-docutils
;                             python-pyyaml
;                             python-rsa
;                             python-s3transfer))
;    (home-page "http://aws.amazon.com/cli/")
;    (synopsis "Universal Command Line Environment for AWS.")
;    (description "Universal Command Line Environment for AWS.")
;    (license #f)))
