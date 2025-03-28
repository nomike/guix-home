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

  (define-public emacs-packages
      (list
          emacs ; The extensible, customizable, self-documenting text editor"
          emacs-magit ; Emacs interface for the Git version control system
          emacs-org ; Outline-based notes management and organizer
          emacs-vlf ; View large files in Emacs
          ; emacs-tuareg ; OCaml programming mode, REPL, debugger for Emacs
          emacs-yaml-mode ; Major mode for editing YAML files
          ; emacs-julia-mode ; Major mode for Julia
          ; emacs-julia-repl ; Minor mode for interacting with a Julia REPL
          ; emacs-julia-snail ; Development environment and REPL interaction package for Julia
          ; emacs-inf-ruby ; Provides a REPL buffer connected to a Ruby subprocess in Emacs
          ; emacs-alchemist; Elixir tooling integration into Emacs
          emacs-code-cells ; Emacs utilities for code split into cells, including Jupyter notebooks
          emacs-password-generator ; Generate passwords inside Emacs
          emacs-casual-calc ; Transient-based porcelain for calc
          emacs-casual-dired ; Transient-based porcelain for Dired
          emacs-casual-info ; Transient-based porcelain for info reader
          emacs-aio ; Async/Await for Emacs Lisp
          emacs-lsp-booster ; not working (package does not exist?)
          emacs-undo-tree ; Emacs LSP performance booster
          ; emacs-page-break-lines ; Display page breaks as tidy horizontal lines ; superseded by emacs-form-feed (?)
          emacs-form-feed ; Display ^L glyphs as horizontal lines
          emacs-next-pgtk ; Emacs text editor with pgtk frames
          emacs-paredit ; Emacs minor mode for editing parentheses
          emacs-evil-paredit ; Evil extension to integrate nicely with Paredit
          emacs-indent-bars ; Highlight indentation with bars
          (emacs-spacious-padding-patch emacs-spacious-padding) ; Increase the padding or spacing of frames and windows
          emacs-crdt ; Real-time collaborative editing environment
          emacs-git-email ; Format and send Git patches in Emacs
          emacs-diff-hl ; Highlight uncommitted changes using VC
          emacs-color-theme-solarized ; Solarized color scheme for Emacs
          emacs-dtrt-indent ; Minor mode that guesses the indentation offset
          emacs-slime-company ; SLIME completion backend for company-mode
          emacs-eval-in-repl-slime ; Superior Lisp Interaction Mode for Emacs
          emacs-pyvenv ; Python virtual environment interface for Emacs
          ;; For Lisp and Javascript; Note: emacs-sly is a fork
          emacs-slime ; Superior Lisp Interaction Mode for Emacs
          emacs-eldoc ; Show function arglist or variable docstring in echo area
          emacs-xref ; Cross-referencing commands ; TODO: emacs-xref-union
          emacs-sesman ; Session manager for Emacs based IDEs
          ; emacs-org-element ; tree
          emacs-org-texlive-collection ; Basic TeX Live packages for Org mode LaTeX export'
          emacs-org-edna ; Manage Org task dependencies
          emacs-org-notify ; Notifications for Org-mode
          emacs-org-node ; Non-hierarchical note-taking with Org-mode, faster thanorg-roam
          emacs-org-super-links ; Create links with auto backlinks 
          ; emacs-org-roam ; Non-hierarchical note-taking with Org mode
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
          emacs-geiser-guile ; Guile Scheme support for Geiser
          emacs-parinfer-rust-mode ; Lisp structure editing mode leveraging Parinfer Rust
                                    ;emacs-parinfer-mode ; Lisp structure editing mode
          emacs-web-mode ; Major mode for editing web templates
          emacs-git-timemachine ; Step through historic versions of Git-controlled files
          emacs-markdown-mode ; Emacs Major mode for Markdown files
          emacs-geiser ; Collection of Emacs modes for Scheme hacking
          emacs-go-mode ; Go mode for Emacs
          emacs-typescript-mode ; Emacs major mode for editing Typescript code
          emacs-pkg-info ; Information about Emacs packages
          ; emacs-flycheck-rust ; Rust/Cargo support for Flycheck
          emacs-rust-mode ; Major Emacs mode for editing Rust source code
          emacs-docker ; anage docker from Emacs
          emacs-dired-launch ; emacs-dired-launch

          emacs-chatgpt-shell ; ChatGPT and DALL-E Emacs shells and Org Babel libraries
          ; dvisvgm ; Command-line utility for generating SVG from DVI, EPS and PDF files ; TODO: Move that to manifest.scm of your project
          ; obsolete in favor of integrated tramp-container
          ; emacs-docker-tramp ; TRAMP integration for docker containers
          emacs-eat ; Terminal emulator in Emacs
          python-jupyter-client ; Jupyter protocol implementation and client libraries ; required by emacs-jupyter (for no reason; why not just invoke "jupyter kernel"?)
          emacs-jupyterv ; Emacs interface to communicate with Jupyter kernels
          emacs-elixir-mode ; ajor mode for editing Elixir files
          emacs-guix ; Emacs interface for GNU Guix
          emacs-bluetooth ; Manage Bluetooth devices using Emacs
          emacs-osmv; OpenStreetMap viewer for Emacs
          emacs-erc-hl-nicks ; Nickname highlighting for Emacs ERC
          emacs-counsel ; Various completion functions using Ivy
          emacs-counsel-tramp ; Ivy interface for TRAMP
          emacs-counsel-projectile ; Enhance Projectile with Ivy
          ; emacs-counsel-jq ; Live preview jq queries using counsel
          ; emacs-helm-projectile ; Helm integration for Projectile
          emacs-company-jedi ; Provides Python completion in company-mode
          emacs-back-button ; Visual navigation through mark rings in Emacs
          ; emacs-wanderlust ; Yet Another Message Interface on Emacsen ; email (POP3, IMAP and Maildir)
          ; (daym) I moved from wanderlust to mew because I find mew has better support for encryption, particularly S/MIME.
          ; emacs-mew ; Emacs e-mail client
          ; mu ; Quickly find emails ; maildir indexer, mu4e
          emacs-vertico ; Vertical interactive completion
          emacs-consult ; Emacs completion style that matches multiple regexps in any order
          ; (patch2 emacs-consult-lsp)) ; (daym) gcc 4.9 build failure
          emacs-consult-xdg-recent-files ; Include files used by other programs than Emacs in Consult
          ; emacs-consult-org-roam ; Consult integration for Org Roam
          emacs-consult-flycheck
          emacs-marginalia
          emacs-orderless
          emacs-trashed
          emacs-qrencode
          emacs-forge
                                    ; Columns
          emacs-taxy-magit-section
          emacs-ghub
          emacs-github-review
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
