  (define-module (emacs-packages)
    #:use-module (gnu home)
    #:use-module (gnu packages)
  
    #:use-module (gnu services)
    #:use-module (guix transformations)
    #:export (emacs-packages))

 (define patch2
   (options->transformation `((with-patch . ,(string-append "emacs-lsp-mode="
                                                            "patches/lsp-mode.patch")))))

 (define emacs-spacious-padding-patch
   (options->transformation `((with-patch . ,(string-append "emacs-spacious-padding="
                                                            "patches/emacs-spacious-padding.patch")))))

  (define-public emacs-packages
      (list
          (specification->package "emacs") ; The extensible, customizable, self-documenting text editor"
          (specification->package "emacs-magit") ; Emacs interface for the Git version control system
          (specification->package "emacs-org") ; Outline-based notes management and organizer
          (specification->package "emacs-vlf") ; View large files in Emacs
          ; (specification->package "emacs-tuareg") ; OCaml programming mode, REPL, debugger for Emacs
          (specification->package "emacs-yaml-mode") ; Major mode for editing YAML files
          ; (specification->package "emacs-julia-mode") ; Major mode for Julia
          ; (specification->package "emacs-julia-repl") ; Minor mode for interacting with a Julia REPL
          ; (specification->package "emacs-julia-snail") ; Development environment and REPL interaction package for Julia
          ; (specification->package "emacs-inf-ruby") ; Provides a REPL buffer connected to a Ruby subprocess in Emacs
          ; (specification->package "emacs-alchemist") ; Elixir tooling integration into Emacs
          (specification->package "emacs-code-cells") ; Emacs utilities for code split into cells, including Jupyter notebooks
          (specification->package "emacs-password-generator") ; Generate passwords inside Emacs
          (specification->package "emacs-casual-calc") ; Transient-based porcelain for calc
          (specification->package "emacs-casual-dired") ; Transient-based porcelain for Dired
          (specification->package "emacs-casual-info") ; Transient-based porcelain for info reader
          (specification->package "emacs-aio") ; Async/Await for Emacs Lisp
          (specification->package "emacs-lsp-booster") ; Emacs LSP performance booster
          (specification->package "emacs-undo-tree") ; Emacs LSP performance booster
          ; (specification->package "emacs-page-break-lines") ; Display page breaks as tidy horizontal lines ; (daym) superseded by emacs-form-feed (?)
          (specification->package "emacs-form-feed") ; Display ^L glyphs as horizontal lines
          (specification->package "emacs-next-pgtk") ; Emacs text editor with pgtk frames
          (specification->package "emacs-paredit") ; Emacs minor mode for editing parentheses
          (specification->package "emacs-evil-paredit") ; Evil extension to integrate nicely with Paredit
          (specification->package "emacs-indent-bars") ; Highlight indentation with bars
          (emacs-spacious-padding-patch (specification->package "emacs-spacious-padding")) ; Increase the padding or spacing of frames and windows
          (specification->package "emacs-crdt") ; Real-time collaborative editing environment
          (specification->package "emacs-git-email") ; Format and send Git patches in Emacs
          (specification->package "emacs-diff-hl") ; Highlight uncommitted changes using VC
          (specification->package "emacs-color-theme-solarized") ; Solarized color scheme for Emacs
          (specification->package "emacs-dtrt-indent") ; Minor mode that guesses the indentation offset
          (specification->package "emacs-slime-company") ; SLIME completion backend for company-mode
          (specification->package "emacs-eval-in-repl-slime") ; Superior Lisp Interaction Mode for Emacs
          (specification->package "emacs-pyvenv") ; Python virtual environment interface for Emacs
          ;; For Lisp and Javascript; Note: emacs-sly is a fork
          (specification->package "emacs-slime") ; Superior Lisp Interaction Mode for Emacs
          (specification->package "emacs-eldoc") ; Show function arglist or variable docstring in echo area
          (specification->package "emacs-xref") ; Cross-referencing commands ; TODO: emacs-xref-union
          (specification->package "emacs-sesman") ; Session manager for Emacs based IDEs
          ; (specification->package "emacs-org-element") ; Seems to no longer exist ; (daym) tree
          (specification->package "emacs-org-texlive-collection") ; Basic TeX Live packages for Org mode LaTeX export'
          (specification->package "emacs-org-edna") ; Manage Org task dependencies
          (specification->package "emacs-org-notify") ; Notifications for Org-mode
          (specification->package "emacs-org-node") ; Non-hierarchical note-taking with Org-mode, faster than org-roam
          (specification->package "emacs-org-super-links") ; Create links with auto backlinks 
          ; (specification->package "emacs-org-roam") ; Non-hierarchical note-taking with Org mode
          (specification->package "emacs-org-ref") ; Citations, cross-references and bibliographies in Org mode 
          (specification->package "emacs-org-super-agenda") ; Supercharged Org agenda 
          (specification->package "emacs-org-timeblock") ; Schedule your day visually, using timeblocking technique inside Emacs 
          (specification->package "emacs-org-remark") ; add notes to epub and websites
          (specification->package "emacs-org-pomodoro") ; Pomodoro technique for org-mode 
          (specification->package "emacs-org-emms") ; Play multimedia files from org-mode 
          (specification->package "emacs-mu4e-dashboard") ; Build your own dashboard for mu4e using org-mode 
          (specification->package "emacs-emms") ; The Emacs Multimedia System
          (specification->package "emacs-comment-tags") ; Minor mode to show comments which have tags like TODO 
          (specification->package "emacs-embark") ; Emacs Mini-Buffer Actions Rooted in Keymaps 
          (specification->package "emacs-outline-indent") ; Outline and code folding for indentation-based texts in Emacs 
          (specification->package "emacs-rmsbolt") ; Emacs viewer for compiler output 
;               ; (daym) Used by emacs-dap-mode
          (patch2 (specification->package "emacs-lsp-treemacs")) ; Integration between LSP mode and treemacs 
;               ; (daym) Used by emacs-dap-mode
          (specification->package "emacs-bui") ; Buffer interface library for Emacs 
;               ; (daym) Used by emacs-dap-mode (popup)
          (specification->package "emacs-posframe") ; Pop a posframe (a child frame) at point 
          (specification->package "emacs-beacon") ; Emacs minor mode creating a light that follows your cursor around 
          (specification->package "emacs-bar-cursor") ; Bar cursor shape 
          (specification->package "emacs-wakib-keys") ; Make C-c, C-v and C-x clipboard keys work reliably in Emacs 
;               ; (daym) Alternative: emacs-dape
          (patch2 (specification->package "emacs-dap-mode")) ; Emacs client/library for Debug Adapter Protocol 
          (patch2 (specification->package "emacs-lsp-mode")) ; Emacs client and library for the Language Server Protocol
          (patch2 (specification->package "emacs-lsp-ui")) ; User interface extensions for `lsp-mode'
;                                         ; (daym) doesn't work emacs-lsp-docker
;                                         ; (daym) part of emacs since emacs 29 emacs-csharp-mode
          (patch2 (specification->package "emacs-ccls")) ; Emacs support for the `ccls' language server ;  C LSP; conflicts with our patched dap-mode
          (patch2 (specification->package "emacs-lsp-java")) ; Java support for lsp-mode ; (daym) conflicts with our patched dap-mode
          (specification->package "emacs-tramp") ; Remote file editing package for Emacs ; (daym) I think that's part of emacs now
          (specification->package "emacs-treemacs") ; Emacs tree style file explorer
          (specification->package "emacs-treemacs-extra") ; Emacs tree style file explorer ; (daym)  magit, projectile, tab-bar; but also all-the-icons, memoize, evil, persp-mode, perspective
          (specification->package "emacs-treemacs-nerd-icons") ; This package provides nerd-icons integration for treemacs.
          ; (specification->package "emacs-magit-gerrit") ; Magit plugin for Gerrit Code Review ; no longer maintained
          (specification->package "emacs-projectile") ; Manage and navigate projects in Emacs easily 
          (specification->package "emacs-company") ; Modular text completion framework
          (specification->package "emacs-company-jedi") ; Provides Python completion in `company-mode' 
          (patch2 (specification->package "emacs-company-lsp")) ; Completion for `lsp-mode' 
          (specification->package "emacs-company-org-block") ; Emacs `company-complete' for Org blocks ; snippets with "<"
          (specification->package "emacs-capf-autosuggest") ; `eshell' completion suggestions for Emacs 
          (specification->package "emacs-flycheck") ; On-the-fly syntax checking 
          (specification->package "emacs-helm") ; Incremental completion and selection narrowing framework for Emacs 
          (specification->package "emacs-shackle") ; Enforce rules for popups 
          (specification->package "emacs-envrc") ; Support for Direnv which operates buffer-locally 
          ; (daym) Understands guix.scm and manifest.scm natively
          (specification->package "emacs-buffer-env") ; Create buffer-local process environments 
          (specification->package "emacs-flycheck-guile") ; GNU Guile support for Flycheck
          (specification->package "emacs-scad-mode") ; Emacs major mode for editing editing OpenSCAD code 
          (specification->package "emacs-geiser-guile") ; Guile Scheme support for Geiser
          (specification->package "emacs-parinfer-rust-mode") ; Lisp structure editing mode leveraging Parinfer Rust
          ; (specification->package "emacs-parinfer-mode ; Lisp structure editing mode
          (specification->package "emacs-web-mode") ; Major mode for editing web templates
          (specification->package "emacs-git-timemachine") ; Step through historic versions of Git-controlled files
          (specification->package "emacs-markdown-mode") ; Emacs Major mode for Markdown files
          (specification->package "emacs-geiser") ; Collection of Emacs modes for Scheme hacking
          (specification->package "emacs-go-mode") ; Go mode for Emacs
          (specification->package "emacs-typescript-mode") ; Emacs major mode for editing Typescript code
          (specification->package "emacs-pkg-info") ; Information about Emacs packages
          ; (specification->package "emacs-flycheck-rust") ; Rust/Cargo support for Flycheck
          (specification->package "emacs-rust-mode") ; Major Emacs mode for editing Rust source code
          (specification->package "emacs-docker") ; anage docker from Emacs
          (specification->package "emacs-dired-launch") ; emacs-dired-launch
          (specification->package "emacs-chatgpt-shell") ; ChatGPT and DALL-E Emacs shells and Org Babel libraries
          ; (specification->package "dvisvgm") ; Command-line utility for generating SVG from DVI, EPS and PDF files ; (daym) TODO: Move that to manifest.scm of your project
          ; (daym) obsolete in favor of integrated tramp-container
          ; (specification->package "emacs-docker-tramp") ; TRAMP integration for docker containers
          (specification->package "emacs-eat") ; Terminal emulator in Emacs
          (specification->package "python-jupyter-client") ; Jupyter protocol implementation and client libraries ; (daym) required by emacs-jupyter (for no reason; why not just invoke "jupyter kernel"?)
          (specification->package "emacs-jupyter") ; Emacs interface to communicate with Jupyter kernels
          (specification->package "emacs-elixir-mode") ; ajor mode for editing Elixir files
          (specification->package "emacs-guix") ; Emacs interface for GNU Guix
          (specification->package "emacs-bluetooth") ; Manage Bluetooth devices using Emacs
          (specification->package "emacs-osm") ; OpenStreetMap viewer for Emacs
          (specification->package "emacs-erc-hl-nicks") ; Nickname highlighting for Emacs ERC
          (specification->package "emacs-counsel") ; Various completion functions using Ivy
          (specification->package "emacs-counsel-tramp") ; Ivy interface for TRAMP
          (specification->package "emacs-counsel-projectile") ; Enhance Projectile with Ivy
          ; (specification->package "emacs-counsel-jq") ; Live preview jq queries using counsel
          ; (specification->package "emacs-helm-projectile") ; Helm integration for Projectile
          (specification->package "emacs-company-jedi") ; Provides Python completion in company-mode
          (specification->package "emacs-back-button") ; Visual navigation through mark rings in Emacs
          ; (specification->package "emacs-wanderlust") ; Yet Another Message Interface on Emacsen ; (daym) email (POP3, IMAP and Maildir)
          ; (daym) I moved from wanderlust to mew because I find mew has better support for encryption, particularly S/MIME.
          ; (specification->package "emacs-mew") ; Emacs e-mail client
          ; (specification->package "mu ; Quickly") find emails ; (daym) maildir indexer, mu4e
          (specification->package "emacs-vertico") ; Vertical interactive completion
          (specification->package "emacs-consult") ; Emacs completion style that matches multiple regexps in any order
          ; (patch2 (specification->package "emacs-consult-lsp"))) ; (daym) gcc 4.9 build failure
          (specification->package "emacs-consult-xdg-recent-files") ; Include files used by other programs than Emacs in Consult
          ; (specification->package "emacs-consult-org-roam") ; Consult integration for Org Roam
          (specification->package "emacs-consult-flycheck") ; Consult integration for Flycheck
          (specification->package "emacs-marginalia") ; Marginalia in the minibuffer completions 
          (specification->package "emacs-orderless") ; Emacs completion style that matches multiple regexps in any order 
          (specification->package "emacs-trashed") ; View and edit system trash can in Emacs 
          (specification->package "emacs-qrencode") ; QRCode encoder for Emacs in pure elisp 
          (specification->package "emacs-forge") ; Access Git forges from Magit 
          (specification->package "emacs-taxy-magit-section") ; View Taxy structs in a Magit Section buffer 
          (specification->package "emacs-ghub") ; Emacs client libraries for the APIs of various Git forges 
          (specification->package "emacs-github-review") ; Review GitHub pull requests within Emacs 
          ; (specification->package "emacs-svg-tag-mode") ; Replace keywords with SVG tags ; replaced by emacs-org-modern
          (specification->package "emacs-org-modern") ; Modern Org style ; (daym) This one uses text styling and so makes the user's stuff more editable than svg-tag-mode ; (daym) Replaces org-bullets and org-superstar
          (specification->package "emacs-ob-async") ; Asynchronous src_block execution for org-babel 
          (specification->package "emacs-mixed-pitch") ; Mix variable- and fixed-pitch fonts in the same Emacs buffer 
          ; (daym) Used by emacs-doom-modeline. Requires nerd font. Can install it via M-x nerd-icons-install-fonts to ~/.local/share/fonts
          ; (daym) Don't forget to M-x customize-variable lsp-treemacs-theme to "Iconless" without quotes. It will show icons from the font anyway.
          (specification->package "emacs-nerd-icons") ; Library for easily using nerd font icons inside Emacs 
          (specification->package "emacs-doom-modeline") ; Fancy and fast mode-line inspired by minimalism design 
          (specification->package "emacs-pulsar") ; Pulse highlight line on demand or after running select functions 
          (specification->package "emacs-rainbow-delimiters") ; Highlight brackets according to their depth 
          ; (daym) What's the difference to which-key ??
          (specification->package "emacs-discover-my-major") ; Discover key bindings for the current Emacs major mode 
          (specification->package "emacs-which-key") ; Display available keybindings in popup 
          (specification->package "emacs-auctex") ; Integrated environment for TeX 
          (specification->package "emacs-company-auctex") ; Completion for `AUCTeX' 
          (specification->package "emacs-latex-extra") ; Usability improvements for LaTeX mode 
          (specification->package "emacs-adoc-mode") ; AsciiDoc mode for Emacs 
          (specification->package "emacs-tempel") ; Simple templates for Emacs 
          (specification->package "emacs-debbugs") ; Access the Debbugs bug tracker in Emacs 
          (specification->package "emacs-inheritenv") ; Emacs temp buffers inherit buffer-local environment variables 
          ; (daym) Alternative: emacs-reformatter
          (specification->package "emacs-format-all-the-code"); Auto-format any source code
          ; (daym) For swank-js to use.  But it doesn't work with multiple major modes yet. TODO: css-mode;
          (specification->package "emacs-js2-mode") ; Improved JavaScript editing mode for Emacs 
          ; (daym) typescript mode done by combobulate
          ; (daym) Allows the user to see/edit a range of a buffer in another buffer.
          (specification->package "emacs-edit-indirect") ; Edit regions in separate buffers 
          ; (daym) This one works with multiple major modes (and thus with Vue JS, mmm)
          ; (daym) shipped by default emacs-js-mode
          (specification->package "emacs-mmm-mode") ; Allow multiple major modes in an Emacs buffer 
          ; (daym) For Clojure. Supports light table via M-x cider-enlighten-mode
          (specification->package "emacs-cider") ; Clojure development environment for Emacs 
          (specification->package "emacs-vala-mode") ; Helm interface to Clojure's CIDER 
          ; (daym) Shows number of search results in status bar
          (specification->package "emacs-anzu") ; Show number of matches in mode-line while searching 
          (specification->package "emacs-dired-rsync") ; Support for rsync from Emacs dired buffers 
          (specification->package "emacs-dockerfile-mode") ; Major mode for editing Dockerfile 
          (specification->package "emacs-emacsql") ; Emacs high-level SQL database front-end 
          ; (specification->package "emacs-helm-cider") ; Helm interface to Clojure's CIDER 
          ; (daym) TODO emacs-graphviz-dot-mode
          (specification->package "emacs-jinja2-mode") ; Major mode for jinja2 
          (specification->package "emacs-org-fc") ; Spaced repetition system for Emacs Org mode 
          (specification->package "emacs-org-vcard") ; Org mode support for vCard export and import 
          (specification->package "emacs-vundo") ; Visualize the undo tree 
          (specification->package "emacs-wttrin") ; Frontend for weather web service `wttr.in' 
          (specification->package "emacs-org-re-reveal") ; Build HTML presentations with reveal.js from Org source files 
          (specification->package "emacs-frames-only-mode") ; Use frames instead of Emacs windows 
          (specification->package "emacs-popper") ; Emacs minor-mode to summon and dismiss buffers easily 
          ; (daym) TODO avy
          ; (daym) doesn't native compile: emacs-mastodon
          (specification->package "emacs-elfeed") ; Atom/RSS feed reader for Emacs 
          (specification->package "emacs-elfeed-score") ; Gnus-style scoring for Elfeed 
          (specification->package "emacs-elfeed-org") ; Configure Elfeed with an Org-mode file 
          (specification->package "emacs-fortran-tags") ; Emacs plugin for source code indexing of modern Fortran 
          ; (daym) or celluloid for gtk
          (specification->package "emacs-mpv") ; Control MPV for easy note taking 
          (specification->package "emacs-empv") ; Emacs multimedia player, media library manager, YouTube frontend 
          ; (specification->package "emacs-ytel") ; Youtube front-end for Emacs 
          (specification->package "emacs-nov-el") ; Major mode for reading EPUBs in Emacs 
          (specification->package "dvisvgm") ; Command-line utility for generating SVG from DVI, EPS and PDF files 
          (specification->package "emacs-ztree") ; Directory tree comparison mode for Emacs 

          ; (daym) Guile IDE
          (specification->package "emacs-arei") ; Asynchronous Reliable Extensible IDE 
          (specification->package "guile-ares-rs") ; Asynchronous Reliable Extensible Sleek RPC Server for Guile 
          (specification->package "tree-sitter-tlaplus") ; Tree-sitter TLA+ grammar 
          (specification->package "emacs-org-sticky-header") ; Always show current org header line 
          (specification->package "pandoc") ; Conversion between markup formats
          (specification->package "emacs-pandoc-mode") ; Minor mode for interacting with Pandoc 
          (specification->package "emacs-ox-pandoc") ; Org exporter for Pandoc 
          (specification->package "emacs-org-pandoc-import") ; Read and edit non-Org file types in Org 
          (specification->package "emacs-org-auto-tangle") ; Automatically tangle code blocks on save 
          (specification->package "emacs-howm") ; Note-taking tool for Emacs 
          (specification->package "emacs-pdf-tools") ; Emacs support library for PDF files 



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
              
                                        ; similar: (package-with-emacs-pgtk (specification->package "emacs-gnosis"))


    )
  )
