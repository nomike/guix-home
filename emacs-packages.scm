  (define-module (emacs-packages)
    #:use-module (gnu home)
    #:use-module (gnu packages)
    #:use-module (gnu services)
    #:use-module (guix transformations)
    #:use-module (gnu packages emacs)
    #:use-module (gnu packages tex)
    #:use-module (gnu packages rust-apps)
    #:use-module (gnu packages version-control)
    #:use-module (gnu packages emacs-xyz)
    #:use-module (gnu packages python-xyz) ; python-black
    #:export (emacs-packages))  ; Explicitly export the emp variable

 (define patch2
   (options->transformation `((with-patch . ,(string-append "emacs-lsp-mode="
                                                            "patches/lsp-mode.patch")))))

 (define emacs-spacious-padding-patch
   (options->transformation `((with-patch . ,(string-append "emacs-spacious-padding="
                                                            "patches/emacs-spacious-padding.patch")))))

 (define (package-with-emacs-pgtk p)
   p
   )

  (define-public emacs-packages
      (list
          emacs
          emacs-magit
          emacs-org
          emacs-vlf ; very large files
          ; emacs-tuareg ; ocaml
          emacs-yaml-mode
          ; emacs-julia-mode ; uses yaml which hangs
          ; emacs-julia-repl
          ; emacs-julia-snail
          ; emacs-inf-ruby
          ; emacs-alchemist); Elixir
          emacs-code-cells
          emacs-password-generator
          emacs-casual-calc
          emacs-casual-dired
          emacs-casual-info
          emacs-aio
          emacs-lsp-booster ; not working (package does not exist?)
          emacs-undo-tree
          ; emacs-page-break-lines ; superseded by emacs-form-feed (?)
          emacs-form-feed
          emacs-next-pgtk
          emacs-paredit
          emacs-evil-paredit
          emacs-indent-bars
          (emacs-spacious-padding-patch emacs-spacious-padding) ; spacing between windows
          emacs-crdt
          
          emacs-git-email
          emacs-diff-hl ; VC diff in the fringe
          emacs-color-theme-solarized
          emacs-dtrt-indent
          emacs-slime-company
              emacs-eval-in-repl-slime
              emacs-pyvenv ; we're not really using that
              ;; For Lisp and Javascript; Note: emacs-sly is a fork
              (package-with-emacs-pgtk emacs-slime)
              (package-with-emacs-pgtk emacs-eldoc)
              (package-with-emacs-pgtk emacs-xref) ; TODO: emacs-xref-union
              (package-with-emacs-pgtk emacs-sesman)
;                                         ;(package-with-emacs-pgtk emacs-org) ; org 9.7.11 is included in emacs
;                                         ;(package-with-emacs-pgtk emacs-org-element) ; tree

;                                         ;(package-with-emacs-pgtk emacs-org-texlive-collection)
              (package-with-emacs-pgtk emacs-org-edna)
;                                         ; TODO: package: (package-with-emacs-pgtk emacs-org-notify)
;                                         ; (package-with-emacs-pgtk emacs-org-node)
              (package-with-emacs-pgtk emacs-org-super-links)
;                                         ;(package-with-emacs-pgtk emacs-org-roam)
              (package-with-emacs-pgtk emacs-org-ref)
              (package-with-emacs-pgtk emacs-org-super-agenda)
              (package-with-emacs-pgtk emacs-org-timeblock)
              (package-with-emacs-pgtk emacs-org-remark) ; add notes to epub and websites
              (package-with-emacs-pgtk emacs-org-pomodoro)
              (package-with-emacs-pgtk emacs-org-emms)
              (package-with-emacs-pgtk emacs-mu4e-dashboard) ; live query mu4e from org
              (package-with-emacs-pgtk emacs-emms)
              (package-with-emacs-pgtk emacs-comment-tags)              
              (package-with-emacs-pgtk emacs-embark)
              (package-with-emacs-pgtk emacs-outline-indent) ; code folding and outlining
              (package-with-emacs-pgtk emacs-rmsbolt) ; godbolt
;               ;; Used by emacs-dap-mode
              (patch2 (package-with-emacs-pgtk emacs-lsp-treemacs))
;               ;; Used by emacs-dap-mode
              (package-with-emacs-pgtk emacs-bui)
;               ;; Used by emacs-dap-mode (popup)
              (package-with-emacs-pgtk emacs-posframe)

              (package-with-emacs-pgtk emacs-beacon)
              (package-with-emacs-pgtk emacs-bar-cursor)
              (package-with-emacs-pgtk emacs-wakib-keys)
              (package-with-emacs-pgtk emacs-treemacs-nerd-icons)
;               ;; Alternative: emacs-dape
              (patch2 (package-with-emacs-pgtk emacs-dap-mode))
              (patch2 (package-with-emacs-pgtk emacs-lsp-mode))
              (patch2 (package-with-emacs-pgtk emacs-lsp-ui))
;                                         ; doesn't work (package-with-emacs-pgtk emacs-lsp-docker)
;                                         ; part of emacs since emacs 29 (package-with-emacs-pgtk emacs-csharp-mode)
              (patch2 (package-with-emacs-pgtk emacs-ccls)) ; C LSP; conflicts with our patched dap-mode
              (patch2 (package-with-emacs-pgtk emacs-lsp-java)) ; conflicts with our patched dap-mode
;                                         ;(package-with-emacs-pgtk emacs-elpy) ; just use dap-python ; elpy is unmaintained
;                                         ;(package-with-emacs-pgtk emacs-tramp) ; I think that's part of emacs now
              ; (package-with-emacs-pgtk emacs-agda2-mode)
              (package-with-emacs-pgtk emacs-treemacs)
              (package-with-emacs-pgtk emacs-treemacs-extra) ; magit, projectile, tab-bar; but also all-the-icons, memoize, evil, persp-mode, perspective
              (package-with-emacs-pgtk emacs-magit-gerrit)
              (package-with-emacs-pgtk emacs-magit-svn)
              (patch2 (package-with-emacs-pgtk emacs-rustic))
              (package-with-emacs-pgtk emacs-projectile)
              (package-with-emacs-pgtk emacs-company)
              (patch2 (package-with-emacs-pgtk emacs-company-lsp))
              (package-with-emacs-pgtk emacs-company-org-block) ; snippets with "<"
              (package-with-emacs-pgtk emacs-capf-autosuggest)
              (package-with-emacs-pgtk emacs-flycheck)
                                        ;(package-with-emacs-pgtk emacs-helm)
              (package-with-emacs-pgtk emacs-shackle)
                                        ;(package-with-emacs-pgtk emacs-envrc)
              ;; Understands guix.scm and manifest.scm natively
              (package-with-emacs-pgtk emacs-buffer-env)
              (package-with-emacs-pgtk emacs-clojure-mode)
              (package-with-emacs-pgtk emacs-haskell-mode)
              (package-with-emacs-pgtk emacs-flycheck-guile)
              (package-with-emacs-pgtk emacs-geiser-guile)
              (package-with-emacs-pgtk emacs-parinfer-rust-mode)
                                        ;(package-with-emacs-pgtk emacs-parinfer-mode)
              (package-with-emacs-pgtk emacs-web-mode)
              (package-with-emacs-pgtk emacs-git-timemachine)
              (package-with-emacs-pgtk emacs-markdown-mode)
              (package-with-emacs-pgtk emacs-geiser)
              (package-with-emacs-pgtk emacs-go-mode)
              (package-with-emacs-pgtk emacs-typescript-mode)
              (package-with-emacs-pgtk emacs-pkg-info)
              (package-with-emacs-pgtk emacs-flycheck-rust)
              (package-with-emacs-pgtk emacs-rust-mode)
              (package-with-emacs-pgtk emacs-docker)
              (package-with-emacs-pgtk emacs-dired-launch)
                                        ;dvisvgm") ; TODO: Move that to manifest.scm of your project
                                        ; obsolete in favor of integrated tramp-container
                                        ;(package-with-emacs-pgtk emacs-docker-tramp)
              (package-with-emacs-pgtk emacs-eat)
;                                         ; statistics: R, Julia, and JAGS.
;                                         ; FIXME (package-with-emacs-pgtk emacs-ess)

              python-jupyter-client ; required by emacs-jupyter (for no reason; why not just invoke "jupyter kernel"?)
              (package-with-emacs-pgtk emacs-jupyter)
              (package-with-emacs-pgtk emacs-elixir-mode)
                                        ; FIXME (package-with-emacs-pgtk emacs-guix)
              (package-with-emacs-pgtk emacs-bluetooth)
              (package-with-emacs-pgtk emacs-osm)
              (package-with-emacs-pgtk emacs-erc-hl-nicks) ; IRC nick coloring
              (package-with-emacs-pgtk emacs-counsel)
              (package-with-emacs-pgtk emacs-counsel-tramp)
              (package-with-emacs-pgtk emacs-counsel-projectile)
                                        ;(package-with-emacs-pgtk emacs-counsel-jq)
                                        ;(package-with-emacs-pgtk emacs-helm-projectile)
              (package-with-emacs-pgtk emacs-company-jedi) ; Python completion
              (package-with-emacs-pgtk emacs-back-button)
                                        ;(package-with-emacs-pgtk emacs-wanderlust) ; email (POP3, IMAP and Maildir)
                                        ;I moved from wanderlust to mew because I find mew has better support for encryption, particularly S/MIME.
                                        ;(package-with-emacs-pgtk emacs-mew)
                                        ; mu") ; maildir indexer, mu4e
              (package-with-emacs-pgtk emacs-vertico)
              (package-with-emacs-pgtk emacs-consult)
                                        ;(patch2 (package-with-emacs-pgtk emacs-consult-lsp)) ; gcc 4.9 build failure
              (package-with-emacs-pgtk emacs-consult-xdg-recent-files)
                                        ;(package-with-emacs-pgtk emacs-consult-org-roam)
              (package-with-emacs-pgtk emacs-consult-flycheck)
              (package-with-emacs-pgtk emacs-marginalia)
              (package-with-emacs-pgtk emacs-orderless)
              (package-with-emacs-pgtk emacs-trashed)
              (package-with-emacs-pgtk emacs-qrencode)
              (package-with-emacs-pgtk emacs-forge)
                                        ; Columns
              (package-with-emacs-pgtk emacs-taxy-magit-section)
              (package-with-emacs-pgtk emacs-ghub)
              (package-with-emacs-pgtk emacs-github-review)
                                        ;(package-with-emacs-pgtk emacs-svg-tag-mode)
              ;; This one uses text styling and so makes the user's stuff more editable than svg-tag-mode
              ;; Replaces org-bullets and org-superstar
              (package-with-emacs-pgtk emacs-org-modern)
              (package-with-emacs-pgtk emacs-ob-async)
              (package-with-emacs-pgtk emacs-mixed-pitch)
              ;; Used by emacs-doom-modeline. Requires nerd font. Can install it via M-x nerd-icons-install-fonts to ~/.local/share/fonts
              ;; Don't forget to M-x customize-variable lsp-treemacs-theme to "Iconless" without quotes. It will show icons from the font anyway.
              (package-with-emacs-pgtk emacs-nerd-icons)
                                        ;(package-with-emacs-pgtk emacs-doom-modeline)
              (package-with-emacs-pgtk emacs-pulsar)
              (package-with-emacs-pgtk emacs-rainbow-delimiters)
              ;; What's the difference to which-key ??
              (package-with-emacs-pgtk emacs-discover-my-major)
              (package-with-emacs-pgtk emacs-which-key)
              (package-with-emacs-pgtk emacs-auctex)
              (package-with-emacs-pgtk emacs-company-auctex)
              (package-with-emacs-pgtk emacs-latex-extra)
              (package-with-emacs-pgtk emacs-adoc-mode)
              (package-with-emacs-pgtk emacs-tempel)
              (package-with-emacs-pgtk emacs-debbugs)
              (package-with-emacs-pgtk emacs-inheritenv)
              ;; Alternative: emacs-reformatter
                                        ;emacs-format-all-the-code") ; can't because inheritenv.
              (package-with-emacs-pgtk emacs-format-all-the-code)

              ;; For swank-js to use.  But it doesn't work with multiple major modes yet. TODO: css-mode;
              (package-with-emacs-pgtk emacs-js2-mode)
                                        ; typescript mode done by combobulate
              ;; Allows the user to see/edit a range of a buffer in another buffer.
              (package-with-emacs-pgtk emacs-edit-indirect)
              ;; This one works with multiple major modes (and thus with Vue JS, mmm)
                                        ; shipped by default (package-with-emacs-pgtk emacs-js-mode)
              ;; Allows multiple major modes to coexist in one buffer
              (package-with-emacs-pgtk emacs-mmm-mode)
              ;; For Clojure. Supports light table via M-x cider-enlighten-mode
              (package-with-emacs-pgtk emacs-cider)
              (package-with-emacs-pgtk emacs-vala-mode)
              ;; Shows number of search results in status bar
              (package-with-emacs-pgtk emacs-anzu)
              (package-with-emacs-pgtk emacs-dired-rsync)
              (package-with-emacs-pgtk emacs-dockerfile-mode)
              (package-with-emacs-pgtk emacs-emacsql)
                                        ;(package-with-emacs-pgtk emacs-helm-cider)
                                        ; TODO (package-with-emacs-pgtk emacs-graphviz-dot-mode)
              (package-with-emacs-pgtk emacs-jinja2-mode)
              ;; Spaced repetition in org mode.
              (package-with-emacs-pgtk emacs-org-fc)
              ;; vcard vcf
              (package-with-emacs-pgtk emacs-org-vcard)
              ;; Visual undo tree.
              (package-with-emacs-pgtk emacs-vundo)
              ;; Weather info
              (package-with-emacs-pgtk emacs-wttrin)
              ;; org->HTML export
              (package-with-emacs-pgtk emacs-org-re-reveal)
                                        ; unused
              (package-with-emacs-pgtk emacs-frames-only-mode)
                                        ; https://github.com/karthink/popper special-case popup windows in general.
              (package-with-emacs-pgtk emacs-popper)
                                        ; TODO avy
                                        ; doesn't native compile: (package-with-emacs-pgtk emacs-mastodon)

              (package-with-emacs-pgtk emacs-elfeed) ; RSS/Atom
              (package-with-emacs-pgtk emacs-elfeed-score)
              (package-with-emacs-pgtk emacs-elfeed-org) ; subscriptions in org mode
              (package-with-emacs-pgtk emacs-fortran-tags)
                                        ; or celluloid for gtk
              (package-with-emacs-pgtk emacs-mpv)
              (package-with-emacs-pgtk emacs-empv) ; ?
                                        ; emacs-ytel
              (package-with-emacs-pgtk emacs-nov-el) ; for epub
              (package-with-emacs-pgtk dvisvgm) ; for epub
              (package-with-emacs-pgtk emacs-ztree) ; directory diff
              ;; Guile IDE
              (package-with-emacs-pgtk (specification->package "emacs-arei"))
              (specification->package "guile-ares-rs")
                                        ; I adapt it (package-with-emacs-pgtk (specification->package "emacs-combobulate"))
                                        ; FIXME https://github.com/mclear-tools/consult-notes
                                        ; and then (consult-notes-org-roam-mode)
                                        ; HELM!?
                                        ;emacs-consult-notmuch
                                        ;emacs-consult-yasnippet
                                        ;emacs-consult-bibtex
                                        ;emacs-consult-dir
                                        ; Ivy[built-in]
                                        ; company-mode
                                        ; consult: Either use the default completion UI or ensure that exactly one of vertico-mode, mct-mode, or icomplete-mode is enabled. The unsupported modes selectrum-mode, ivy-mode, helm-mode, ido-mode and ido-ubiquitous-mode must be disabled.
                                        ; emacs vertico uses built-in completion; better than helm
                                        ;(let ((base (specification->package "mogan")))
                                        ;          (package (inherit base)
                                        ;            (inputs
                                        ;             (modify-inputs (package-inputs base)
                                        ;                            ;(prepend qtwayland-5)
                                        ;                            ))))

              ;; Scientist.
                                        ; (specification->package "texmacs-guile3")
                                        ; (package-with-emacs-pgtk (specification->package "emacs-zotxt"))
                                        ; (specification->package "zotero")

;;; Theorem Proving

                                        ;(specification->package "agda")
                                        ;(specification->package "lean") ; used by Terence Tao
                                        ;(specification->package "tla2tools")
              (specification->package "tree-sitter-tlaplus")

;;; Learning
            
                                        ; (specification->package "anki")
              ;; One of the problems with one-way sync/extract from org-mode files to Anki database is losing out the context (imagine notes from a technical books).
              ;; I use org-drill in combination with org-sticky-header, which show the path of headings to that particular node.
              ;; Normally in Anki, this requires to add some extra descriptions or tags for this purpose. In org-mode, we get this for free.
              ;; But on the other hand, org-drill will fill your org file with scheduling and metadata drawers.
              ;; Another drawback with org-drill is it manages schedules for one "card" per heading, hence cloze items are not scheduled individually.
              ;; So, either you remember entirely "Alfred North Whitehead wrote [Principia Mathematica] in [1910]" or not at all.
              ;; In Anki, not only the book title "[Principia Mathematica]" and the written year "[1910]" are tested separately (same as org-drill),
              ;; but also scheduled/scored separately too (where org-drill falls short).
              ;; Use both, org-drill mostly for books, Anki for "standalone" facts.
                                        ; (package-with-emacs-pgtk (specification->package "emacs-anki-editor"))
                                        ; (package-with-emacs-pgtk (specification->package "emacs-gnosis"))
              ;; https://github.com/louietan/anki-editor
                                        ; (package-with-emacs-pgtk (specification->package "emacs-org-drill"))
              (package-with-emacs-pgtk (specification->package "emacs-org-sticky-header"))
                                        ; similar: (package-with-emacs-pgtk (specification->package "emacs-gnosis"))

              (specification->package "pandoc")
              (package-with-emacs-pgtk (specification->package "emacs-pandoc-mode"))
              (package-with-emacs-pgtk (specification->package "emacs-ox-pandoc"))
              (package-with-emacs-pgtk (specification->package "emacs-org-pandoc-import"))
              (package-with-emacs-pgtk (specification->package "emacs-org-auto-tangle"))
              (package-with-emacs-pgtk (specification->package "emacs-howm")) ; minor mode for wiki

              (package-with-emacs-pgtk (specification->package "emacs-pdf-tools"))

    )
  )
