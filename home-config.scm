;;; Local modules live next to this file.  Register that directory before
;;; they are resolved so `guix home reconfigure home-config.scm' works
;;; without GUILE_LOAD_PATH or `-L'.
(eval-when (expand load eval)
  (let* ((file (or (current-filename)
                   (and (file-exists? "home-config.scm")
                        (canonicalize-path "home-config.scm"))))
         (here (and file (dirname file))))
    (when here
      (let ((canonical (canonicalize-path here)))
        (unless (member canonical %load-path)
          (add-to-load-path canonical))))))

(use-modules (gnu home)
             (gnu packages base)
             (roles scrooge)
             (modules zsh))

(home-environment
 (packages
  (append scrooge-packages
          (list)))
 ;; (services
 ;;  (list
 ;;   zsh-service))
 )
