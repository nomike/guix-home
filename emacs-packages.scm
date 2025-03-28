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
    #:use-module (gnu packages engineering)
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
          emacs-pyvenv
          ;; For Lisp and Javascript; Note: emacs-sly is a fork
          emacs-slime
          emacs-eldoc
          emacs-xref ; TODO: emacs-xref-union
          emacs-sesman
;                                         ;emacs-org ; org 9.7.11 is included in emacs
;                                         ;emacs-org-element ; tree

;                                         ;emacs-org-texlive-collection)
          emacs-org-edna
;                                         ; TODO: package: emacs-org-notify
;                                         ; emacs-org-node)
              emacs-org-super-links ; Create links with auto backlinks 
;                                         ;emacs-org-roam)
              emacs-org-ref ; Citations, cross-references and bibliographies in Org mode 
              emacs-org-super-agenda ; Supercharged Org agenda 
              emacs-org-timeblock ; Schedule your day visually, using timeblocking technique inside Emacs 
              emacs-org-remark ; add notes to epub and websites
              emacs-org-pomodoro ; Pomodoro technique for org-mode 
              emacs-org-emms ; Play multimedia files from org-mode 
              emacs-mu4e-dashboard ; Build your own dashboard for mu4e using org-mode 
              emacs-emms ; The Emacs Multimedia System
              emacs-comment-tags ; Minor mode to show comments which have tags like TODO 
              emacs-embark ; Emacs Mini-Buffer Actions Rooted in Keymaps 
              emacs-outline-indent ; Outline and code folding for indentation-based texts in Emacs 
              emacs-rmsbolt ; Emacs viewer for compiler output 
;               ;; Used by emacs-dap-mode
              (patch2 emacs-lsp-treemacs) ; Integration between LSP mode and treemacs 
;               ;; Used by emacs-dap-mode
              emacs-bui ; Buffer interface library for Emacs 
;               ;; Used by emacs-dap-mode (popup)
              emacs-posframe ; Pop a posframe (a child frame) at point 

              emacs-beacon ; Emacs minor mode creating a light that follows your cursor around 
              emacs-bar-cursor ; Bar cursor shape 
              emacs-wakib-keys ; Make C-c, C-v and C-x clipboard keys work reliably in Emacs 
;               ;; Alternative: emacs-dape
              (patch2 emacs-dap-mode) ; Emacs client/library for Debug Adapter Protocol 
              (patch2 emacs-lsp-mode) ; Emacs client and library for the Language Server Protocol
              (patch2 emacs-lsp-ui) ; User interface extensions for `lsp-mode'
;                                         ; doesn't work emacs-lsp-docker)
;                                         ; part of emacs since emacs 29 emacs-csharp-mode)
              (patch2 emacs-ccls) ; Emacs support for the `ccls' language server ;  C LSP; conflicts with our patched dap-mode
              (patch2 emacs-lsp-java) ; Java support for lsp-mode ; conflicts with our patched dap-mode
              emacs-tramp ; Remote file editing package for Emacs ; I think that's part of emacs now
              emacs-treemacs ; Emacs tree style file explorer
              emacs-treemacs-extra ; Emacs tree style file explorer ; magit, projectile, tab-bar; but also all-the-icons, memoize, evil, persp-mode, perspective
              emacs-treemacs-nerd-icons ; This package provides nerd-icons integration for treemacs.
              ; emacs-magit-gerrit ; Magit plugin for Gerrit Code Review ; no longer maintained
              emacs-projectile ; Manage and navigate projects in Emacs easily 
              emacs-company ; Modular text completion framework
              emacs-company-jedi ; Provides Python completion in `company-mode' 
              (patch2 emacs-company-lsp) ; Completion for `lsp-mode' 
              emacs-company-org-block ; Emacs `company-complete' for Org blocks ; snippets with "<"
              emacs-capf-autosuggest ; `eshell' completion suggestions for Emacs 
              emacs-flycheck ; On-the-fly syntax checking 
              emacs-helm ; Incremental completion and selection narrowing framework for Emacs 
              emacs-shackle ; Enforce rules for popups 
              emacs-envrc ; Support for Direnv which operates buffer-locally 
              ;; Understands guix.scm and manifest.scm natively
              emacs-buffer-env ; Create buffer-local process environments 
              emacs-flycheck-guile ; GNU Guile support for Flycheck

              emacs-scad-mode ; Emacs major mode for editing editing OpenSCAD code 

;               emacs-geiser-guile
;               emacs-parinfer-rust-mode
;                                         ;emacs-parinfer-mode)
;               emacs-web-mode
;               emacs-git-timemachine
;               emacs-markdown-mode
;               emacs-geiser
;               emacs-go-mode
;               emacs-typescript-mode
;               emacs-pkg-info
;               emacs-flycheck-rust
;               emacs-rust-mode
;               emacs-docker
;               emacs-dired-launch
;                                         ;dvisvgm") ; TODO: Move that to manifest.scm of your project
;                                         ; obsolete in favor of integrated tramp-container
;                                         ;emacs-docker-tramp)
;               emacs-eat
; ;                                         ; statistics: R, Julia, and JAGS.
; ;                                         ; FIXME emacs-ess

;               python-jupyter-client ; required by emacs-jupyter (for no reason; why not just invoke "jupyter kernel"?)
;               emacs-jupyter
;               emacs-elixir-mode
;                                         ; FIXME emacs-guix
;               emacs-bluetooth
;               emacs-osm
;               emacs-erc-hl-nicks ; IRC nick coloring
;               emacs-counsel
;               emacs-counsel-tramp
;               emacs-counsel-projectile
;                                         ;emacs-counsel-jq)
;                                         ;emacs-helm-projectile)
;               emacs-company-jedi ; Python completion
;               emacs-back-button
;                                         ;emacs-wanderlust) ; email (POP3, IMAP and Maildir)
;                                         ;I moved from wanderlust to mew because I find mew has better support for encryption, particularly S/MIME.
;                                         ;emacs-mew)
;                                         ; mu") ; maildir indexer, mu4e
;               emacs-vertico
;               emacs-consult
;                                         ;(patch2 emacs-consult-lsp)) ; gcc 4.9 build failure
;               emacs-consult-xdg-recent-files
;                                         ;emacs-consult-org-roam)
;               emacs-consult-flycheck
;               emacs-marginalia
;               emacs-orderless
;               emacs-trashed
;               emacs-qrencode
;               emacs-forge
;                                         ; Columns
;               emacs-taxy-magit-section
;               emacs-ghub
;               emacs-github-review
;                                         ;emacs-svg-tag-mode)
;               ;; This one uses text styling and so makes the user's stuff more editable than svg-tag-mode
;               ;; Replaces org-bullets and org-superstar
;               emacs-org-modern
;               emacs-ob-async
;               emacs-mixed-pitch
;               ;; Used by emacs-doom-modeline. Requires nerd font. Can install it via M-x nerd-icons-install-fonts to ~/.local/share/fonts
;               ;; Don't forget to M-x customize-variable lsp-treemacs-theme to "Iconless" without quotes. It will show icons from the font anyway.
;               emacs-nerd-icons
;                                         ;emacs-doom-modeline)
;               emacs-pulsar
;               emacs-rainbow-delimiters
;               ;; What's the difference to which-key ??
;               emacs-discover-my-major
;               emacs-which-key
;               emacs-auctex
;               emacs-company-auctex
;               emacs-latex-extra
;               emacs-adoc-mode
;               emacs-tempel
;               emacs-debbugs
;               emacs-inheritenv
;               ;; Alternative: emacs-reformatter
;                                         ;emacs-format-all-the-code") ; can't because inheritenv.
;               emacs-format-all-the-code

;               ;; For swank-js to use.  But it doesn't work with multiple major modes yet. TODO: css-mode;
;               emacs-js2-mode
;                                         ; typescript mode done by combobulate
;               ;; Allows the user to see/edit a range of a buffer in another buffer.
;               emacs-edit-indirect
;               ;; This one works with multiple major modes (and thus with Vue JS, mmm)
;                                         ; shipped by default emacs-js-mode)
;               ;; Allows multiple major modes to coexist in one buffer
;               emacs-mmm-mode
;               ;; For Clojure. Supports light table via M-x cider-enlighten-mode
;               emacs-cider
;               emacs-vala-mode
;               ;; Shows number of search results in status bar
;               emacs-anzu
;               emacs-dired-rsync
;               emacs-dockerfile-mode
;               emacs-emacsql
;                                         ;emacs-helm-cider)
;                                         ; TODO emacs-graphviz-dot-mode)
;               emacs-jinja2-mode
;               ;; Spaced repetition in org mode.
;               emacs-org-fc
;               ;; vcard vcf
;               emacs-org-vcard
;               ;; Visual undo tree.
;               emacs-vundo
;               ;; Weather info
;               emacs-wttrin
;               ;; org->HTML export
;               emacs-org-re-reveal
;                                         ; unused
;               emacs-frames-only-mode
;                                         ; https://github.com/karthink/popper special-case popup windows in general.
;               emacs-popper
;                                         ; TODO avy
;                                         ; doesn't native compile: emacs-mastodon

;               emacs-elfeed ; RSS/Atom
;               emacs-elfeed-score
;               emacs-elfeed-org ; subscriptions in org mode
;               emacs-fortran-tags
;                                         ; or celluloid for gtk
;               emacs-mpv
;               emacs-empv ; ?
;                                         ; emacs-ytel
;               emacs-nov-el ; for epub
;               dvisvgm ; for epub
;               emacs-ztree ; directory diff
;               ;; Guile IDE
;               (specification->package "emacs-arei")
;               (specification->package "guile-ares-rs")
;                                         ; I adapt it (package-with-emacs-pgtk (specification->package "emacs-combobulate"))
;                                         ; FIXME https://github.com/mclear-tools/consult-notes
;                                         ; and then (consult-notes-org-roam-mode)
;                                         ; HELM!?
;                                         ;emacs-consult-notmuch
;                                         ;emacs-consult-yasnippet
;                                         ;emacs-consult-bibtex
;                                         ;emacs-consult-dir
;                                         ; Ivy[built-in]
;                                         ; company-mode
;                                         ; consult: Either use the default completion UI or ensure that exactly one of vertico-mode, mct-mode, or icomplete-mode is enabled. The unsupported modes selectrum-mode, ivy-mode, helm-mode, ido-mode and ido-ubiquitous-mode must be disabled.
;                                         ; emacs vertico uses built-in completion; better than helm
;                                         ;(let ((base (specification->package "mogan")))
;                                         ;          (package (inherit base)
;                                         ;            (inputs
;                                         ;             (modify-inputs (package-inputs base)
;                                         ;                            ;(prepend qtwayland-5)
;                                         ;                            ))))

;               ;; Scientist.
;                                         ; (specification->package "texmacs-guile3")
;                                         ; (package-with-emacs-pgtk (specification->package "emacs-zotxt"))
;                                         ; (specification->package "zotero")

; ;;; Theorem Proving

;                                         ;(specification->package "agda")
;                                         ;(specification->package "lean") ; used by Terence Tao
;                                         ;(specification->package "tla2tools")
;               (specification->package "tree-sitter-tlaplus")

; ;;; Learning
            
;                                         ; (specification->package "anki")
;               ;; One of the problems with one-way sync/extract from org-mode files to Anki database is losing out the context (imagine notes from a technical books).
;               ;; I use org-drill in combination with org-sticky-header, which show the path of headings to that particular node.
;               ;; Normally in Anki, this requires to add some extra descriptions or tags for this purpose. In org-mode, we get this for free.
;               ;; But on the other hand, org-drill will fill your org file with scheduling and metadata drawers.
;               ;; Another drawback with org-drill is it manages schedules for one "card" per heading, hence cloze items are not scheduled individually.
;               ;; So, either you remember entirely "Alfred North Whitehead wrote [Principia Mathematica] in [1910]" or not at all.
;               ;; In Anki, not only the book title "[Principia Mathematica]" and the written year "[1910]" are tested separately (same as org-drill),
;               ;; but also scheduled/scored separately too (where org-drill falls short).
;               ;; Use both, org-drill mostly for books, Anki for "standalone" facts.
;                                         ; (package-with-emacs-pgtk (specification->package "emacs-anki-editor"))
;                                         ; (package-with-emacs-pgtk (specification->package "emacs-gnosis"))
;               ;; https://github.com/louietan/anki-editor
;                                         ; (package-with-emacs-pgtk (specification->package "emacs-org-drill"))
;               (specification->package "emacs-org-sticky-header")
;                                         ; similar: (package-with-emacs-pgtk (specification->package "emacs-gnosis"))

;               (specification->package "pandoc")
;               (specification->package "emacs-pandoc-mode")
;               (specification->package "emacs-ox-pandoc")
;               (specification->package "emacs-org-pandoc-import")
;               (specification->package "emacs-org-auto-tangle")
;               (specification->package "emacs-howm") ; minor mode for wiki

;               (specification->package "emacs-pdf-tools")

    )
  )
