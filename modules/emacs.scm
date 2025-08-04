  (define-module (modules emacs)
    #:use-module (gnu home)
    #:use-module (gnu packages)
    #:use-module (guix build-system emacs)
    #:use-module (guix packages)
    #:use-module (guix gexp)
    #:use-module (gnu packages emacs)
    #:use-module (gnu services)
    #:use-module (guix transformations))

(define emacs-guix
        (specification->package "emacs-guix"))

(define-public emacs-guix-minimal
  (package
    (inherit emacs-guix)
    (build-system emacs-build-system)
    (native-inputs '())
    (inputs '())
    (propagated-inputs '())
    (arguments
     (list
      #:include ''("\
^guix-(auto-mode|build-log|derivation|env-var|prettify|scheme|utils)\\.el")
      #:modules '((guix build emacs-build-system)
                  (guix build utils)
                  (srfi srfi-26)
                  (srfi srfi-71)
                  (ice-9 regex)
                  (ice-9 textual-ports))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'unpack 'patch-source
            (lambda _
              (chdir "elisp")
              (let* ((all (call-with-input-file "guix-utils.el"
                            get-string-all))
                     (match-str
                      (lambda (from to base)
                        (let ((res (string-match
                                    (string-append "(" from ".*)" to)
                                    base)))
                          (values (and res (match:substring res 1))
                                  (match:suffix res)))))
                     (pprint rest (match-str
                                   "\\(cl-defun guix-pretty-print-buffer"
                                   "\\(defun guix-pretty-print-file"
                                   all))
                     (search rest (match-str
                                  "\\(defmacro guix-while-search"
                                   "\\(defmacro guix-while-null"
                                   rest)))
                (substitute* "guix-build-log.el"
                 (("guix-find-file-or-url") "find-file-existing"))
                (substitute* "guix-derivation.el"
                  (("guix-find-file") "find-file-existing"))
                (call-with-output-file "guix-utils.el"
                  (lambda (port)
                    (display "(require 'cl-lib)\n\n" port)
                    (for-each
                     (cut display <> port)
                     (list pprint search
                           (match-str ";;; Fontification" ";;; Diff" rest)))
                    (display "(provide 'guix-utils)" port)))))))))
    (description
     (string-append (package-description emacs-guix) "

Note: This is a minimalist variant of emacs-guix, with simply
file prettification."))))

(define patch2
  (options->transformation `((with-patch . ,(string-append "emacs-lsp-mode="
                                                           "patches/lsp-mode.patch")))))

(define emacs-spacious-padding-patch
  (options->transformation `((with-patch . ,(string-append "emacs-spacious-padding="
                                                           "patches/emacs-spacious-padding.patch")))))

(define-public emacs-packages
  (append
   ;; (list
   ;;  emacs-guix-minimal
   ;;  )
    (specifications->packages
      (list
        "emacs-pgtk" ; This Emacs build implements graphical UI purely in terms of GTK.
        "emacs-magit" ; Emacs interface for the Git version control system
        "emacs-multiple-cursors" ; Multiple cursors for Emacs
        "emacs-org" ; Outline-based notes management and organizer
        "emacs-vlf" ; View large files in Emacs
        ; "emacs-tuareg" ; OCaml programming mode, REPL, debugger for Emacs
        "emacs-yaml-mode" ; Major mode for editing YAML files
        ; "emacs-julia-mode" ; Major mode for Julia
        ; "emacs-julia-repl" ; Minor mode for interacting with a Julia REPL
        ; "emacs-julia-snail" ; Development environment and REPL interaction package for Julia
        ; "emacs-inf-ruby" ; Provides a REPL buffer connected to a Ruby subprocess in Emacs
        ; "emacs-alchemist" ; Elixir tooling integration into Emacs
        "emacs-code-cells" ; Emacs utilities for code split into cells, including Jupyter notebooks
        "emacs-password-generator" ; Generate passwords inside Emacs
        "emacs-casual" ; Transient user interfaces for various modes
        "emacs-aio" ; Async/Await for Emacs Lisp
        "emacs-lsp-booster" ; Emacs LSP performance booster
        "emacs-undo-tree" ; Emacs LSP performance booster
        ; emacs-page-break-lines" ; Display page breaks as tidy horizontal lines ; (daym) superseded by emacs-form-feed (?)
        "emacs-form-feed" ; Display ^L glyphs as horizontal lines
        "emacs-next-pgtk" ; Emacs text editor with pgtk frames
        "emacs-paredit" ; Emacs minor mode for editing parentheses
        "emacs-minimap" ; Sidebar showing a _mini-map_ of a buffer
        "emacs-buffer-move" ; emacs-buffer-move
        "emacs-move-text" ; Move current line or region with M-up or M-down
        "emacs-modus-themes" ; Accessible themes for Emacs (WCAG AAA standard)
        "emacs-evil-paredit" ; Evil extension to integrate nicely with Paredit
        "emacs-indent-bars" ; Highlight indentation with bars
        "emacs-crdt" ; Real-time collaborative editing environment
        "emacs-git-email" ; Format and send Git patches in Emacs
        "emacs-diff-hl" ; Highlight uncommitted changes using VC
        "emacs-color-theme-solarized" ; Solarized color scheme for Emacs
        "emacs-dtrt-indent" ; Minor mode that guesses the indentation offset
        "emacs-slime-company" ; SLIME completion backend for company-mode
        "emacs-eval-in-repl-slime" ; Superior Lisp Interaction Mode for Emacs
        "emacs-pyvenv" ; Python virtual environment interface for Emacs
        ; (daym) For Lisp and Javascript; Note: emacs-sly is a fork
        "emacs-slime" ; Superior Lisp Interaction Mode for Emacs
        "emacs-eldoc" ; Show function arglist or variable docstring in echo area
        "emacs-xref" ; Cross-referencing commands ; TODO: emacs-xref-union
        "emacs-sesman" ; Session manager for Emacs based IDEs
        ; "emacs-org-element" ; Seems to no longer exist ; (daym) tree
        "emacs-org-texlive-collection" ; Basic TeX Live packages for Org mode LaTeX export'
        "emacs-org-edna" ; Manage Org task dependencies
        "emacs-org-notify" ; Notifications for Org-mode
        "emacs-org-node" ; Non-hierarchical note-taking with Org-mode, faster than org-roam
        "emacs-org-super-links" ; Create links with auto backlinks 
        ; "macs-org-roam" ; Non-hierarchical note-taking with Org mode
        "emacs-org-ref" ; Citations, cross-references and bibliographies in Org mode 
        "emacs-org-super-agenda" ; Supercharged Org agenda 
        "emacs-org-timeblock" ; Schedule your day visually, using timeblocking technique inside Emacs 
        "emacs-org-remark" ; add notes to epub and websites
        "emacs-org-pomodoro" ; Pomodoro technique for org-mode 
        "emacs-org-emms" ; Play multimedia files from org-mode 
        "emacs-mu4e-dashboard" ; Build your own dashboard for mu4e using org-mode 
        "emacs-emms" ; The Emacs Multimedia System
        "emacs-comment-tags" ; Minor mode to show comments which have tags like TODO 
        "emacs-embark" ; Emacs Mini-Buffer Actions Rooted in Keymaps 
        "emacs-outline-indent" ; Outline and code folding for indentation-based texts in Emacs 
        "emacs-rmsbolt" ; Emacs viewer for compiler output 
  ;               ; (daym) Used by emacs-dap-mode
        "emacs-bui" ; Buffer interface library for Emacs 
  ;               ; (daym) Used by emacs-dap-mode (popup)
        "emacs-posframe" ; Pop a posframe (a child frame) at point 
        "emacs-beacon" ; Emacs minor mode creating a light that follows your cursor around 
        "emacs-bar-cursor" ; Bar cursor shape 
        "emacs-wakib-keys" ; Make C-c, C-v and C-x clipboard keys work reliably in Emacs 
        "emacs-saveplace-pdf-view" ; Save place in pdf-view buffers for Emacs
  ;               ; (daym) Alternative: emacs-dape
        "emacs-tramp" ; Remote file editing package for Emacs ; (daym) I think that's part of emacs now
        "emacs-treemacs" ; Emacs tree style file explorer
        "emacs-treemacs-extra" ; Emacs tree style file explorer ; (daym)  magit, projectile, tab-bar; but also all-the-icons, memoize, evil, persp-mode, perspective
        "emacs-treemacs-nerd-icons" ; This package provides nerd-icons integration for treemacs.
        ; "emacs-magit-gerrit" ; Magit plugin for Gerrit Code Review ; no longer maintained
        "emacs-projectile" ; Manage and navigate projects in Emacs easily 
        "emacs-company" ; Modular text completion framework
        "emacs-company-jedi" ; Provides Python completion in `company-mode' 
        "emacs-company-org-block" ; Emacs `company-complete' for Org blocks ; snippets with "<"
        "emacs-capf-autosuggest" ; `eshell' completion suggestions for Emacs 
        "emacs-flycheck" ; On-the-fly syntax checking 
        "emacs-helm" ; Incremental completion and selection narrowing framework for Emacs 
        "emacs-shackle" ; Enforce rules for popups 
        "emacs-envrc" ; Support for Direnv which operates buffer-locally 
        ; (daym) Understands guix.scm and manifest.scm natively
        "emacs-buffer-env" ; Create buffer-local process environments
        "emacs-buffer-move" ; Functions for moving Emacs' buffers around
        "emacs-flycheck-guile" ; GNU Guile support for Flycheck
        ;; "emacs-scad-mode" ; Emacs major mode for editing editing OpenSCAD code 
        ;; "scad-dbus" ; Control OpenSCAD from Emacs using D-Bus
        "emacs-geiser-guile" ; Guile Scheme support for Geiser
        "emacs-parinfer-rust-mode" ; Lisp structure editing mode leveraging Parinfer Rust
        ; "emacs-parinfer-mode" ; Lisp structure editing mode
        "emacs-web-mode" ; Major mode for editing web templates
        "emacs-git-timemachine" ; Step through historic versions of Git-controlled files
        "emacs-markdown-mode" ; Emacs Major mode for Markdown files
        "emacs-geiser" ; Collection of Emacs modes for Scheme hacking
        "emacs-go-mode" ; Go mode for Emacs
        "emacs-typescript-mode" ; Emacs major mode for editing Typescript code
        "emacs-pkg-info" ; Information about Emacs packages
        ; "emacs-flycheck-rust" ; Rust/Cargo support for Flycheck
        "emacs-rust-mode" ; Major Emacs mode for editing Rust source code
        "emacs-docker" ; anage docker from Emacs
        "emacs-dired-launch" ; emacs-dired-launch
        "emacs-chatgpt-shell" ; ChatGPT and DALL-E Emacs shells and Org Babel libraries
        ; "dvisvgm" ; Command-line utility for generating SVG from DVI, EPS and PDF files ; (daym) TODO: Move that to manifest.scm of your project
        ; (daym) obsolete in favor of integrated tramp-container
        ; "emacs-docker-tramp" ; TRAMP integration for docker containers
        "emacs-eat" ; Terminal emulator in Emacs
        "emacs-gptel" ; GPTel is a simple ChatGPT client for Emacs
        "python-jupyter-client" ; Jupyter protocol implementation and client libraries ; (daym) required by emacs-jupyter (for no reason; why not just invoke "jupyter kernel"?)
        "emacs-jupyter" ; Emacs interface to communicate with Jupyter kernels
        "emacs-elixir-mode" ; ajor mode for editing Elixir files
        ; "emacs-guix" ; Emacs interface for GNU Guix
        "emacs-bluetooth" ; Manage Bluetooth devices using Emacs
        "emacs-osm"; OpenStreetMap viewer for Emacs
        "emacs-erc-hl-nicks" ; Nickname highlighting for Emacs ERC
        "emacs-counsel" ; Various completion functions using Ivy
        "emacs-counsel-tramp" ; Ivy interface for TRAMP
        "emacs-counsel-projectile" ; Enhance Projectile with Ivy
        ; "emacs-counsel-jq" ; Live preview jq queries using counsel
        ; "emacs-helm-projectile" ; Helm integration for Projectile
        "emacs-company-jedi" ; Provides Python completion in company-mode
        "emacs-back-button" ; Visual navigation through mark rings in Emacs
        ; "emacs-wanderlust" ; Yet Another Message Interface on Emacsen ; (daym) email (POP3, IMAP and Maildir)
        ; (daym) I moved from wanderlust to mew because I find mew has better support for encryption, particularly S/MIME.
        ; "emacs-mew" ; Emacs e-mail client
        ; "mu" ; Quickly find emails ; (daym) maildir indexer, mu4e
        "emacs-vertico" ; Vertical interactive completion
        "emacs-consult" ; Emacs completion style that matches multiple regexps in any order
        "emacs-consult-xdg-recent-files" ; Include files used by other programs than Emacs in Consult
        ; "emacs-consult-org-roam" ; Consult integration for Org Roam
        "emacs-consult-flycheck" ; Consult integration for Flycheck
        "emacs-marginalia" ; Marginalia in the minibuffer completions 
        "emacs-orderless" ; Emacs completion style that matches multiple regexps in any order 
        "emacs-trashed" ; View and edit system trash can in Emacs 
        "emacs-qrencode" ; QRCode encoder for Emacs in pure elisp 
        "emacs-forge" ; Access Git forges from Magit 
        "emacs-taxy-magit-section" ; View Taxy structs in a Magit Section buffer 
        "emacs-ghub" ; Emacs client libraries for the APIs of various Git forges 
        "emacs-github-review" ; Review GitHub pull requests within Emacs 
        ; "emacs-svg-tag-mode" ; Replace keywords with SVG tags ; replaced by emacs-org-modern
        "emacs-org-modern" ; Modern Org style ; (daym) This one uses text styling and so makes the user's stuff more editable than svg-tag-mode ; (daym) Replaces org-bullets and org-superstar
        "emacs-ob-async" ; Asynchronous src_block execution for org-babel 
        "emacs-mixed-pitch" ; Mix variable- and fixed-pitch fonts in the same Emacs buffer 
        ; (daym) Used by emacs-doom-modeline. Requires nerd font. Can install it via M-x nerd-icons-install-fonts to ~/.local/share/fonts
        ; (daym) Don't forget to M-x customize-variable lsp-treemacs-theme to "Iconless" without quotes. It will show icons from the font anyway.
        "emacs-nerd-icons" ; Library for easily using nerd font icons inside Emacs 
        "emacs-doom-modeline" ; Fancy and fast mode-line inspired by minimalism design 
        "emacs-pulsar" ; Pulse highlight line on demand or after running select functions 
        "emacs-rainbow-delimiters" ; Highlight brackets according to their depth 
        ; (daym) What's the difference to which-key ??
        "emacs-discover-my-major" ; Discover key bindings for the current Emacs major mode 
        "emacs-which-key" ; Display available keybindings in popup 
        "emacs-auctex" ; Integrated environment for TeX 
        "emacs-company-auctex" ; Completion for `AUCTeX'
	"emacs-powerline" ; Mode-line plugin for Emacs
        "emacs-latex-extra" ; Usability improvements for LaTeX mode 
        "emacs-adoc-mode" ; AsciiDoc mode for Emacs 
        "emacs-tempel" ; Simple templates for Emacs 
        "emacs-debbugs" ; Access the Debbugs bug tracker in Emacs 
        "emacs-inheritenv" ; Emacs temp buffers inherit buffer-local environment variables 
        ; (daym) Alternative: emacs-reformatter
        "emacs-format-all-the-code" ; Auto-format any source code
        ; (daym) For swank-js to use.  But it doesn't work with multiple major modes yet. TODO: css-mode;
        "emacs-js2-mode" ; Improved JavaScript editing mode for Emacs 
        ; (daym) typescript mode done by combobulate
        ; (daym) Allows the user to see/edit a range of a buffer in another buffer.
        "emacs-edit-indirect" ; Edit regions in separate buffers 
        ; (daym) This one works with multiple major modes (and thus with Vue JS, mmm)
        ; (daym) shipped by default emacs-js-mode
        "emacs-mmm-mode" ; Allow multiple major modes in an Emacs buffer 
        ; (daym) For Clojure. Supports light table via M-x cider-enlighten-mode
        "emacs-cider" ; Clojure development environment for Emacs 
        "emacs-vala-mode" ; Helm interface to Clojure's CIDER 
        ; (daym) Shows number of search results in status bar
        "emacs-anzu" ; Show number of matches in mode-line while searching 
        "emacs-dired-rsync" ; Support for rsync from Emacs dired buffers 
        "emacs-dockerfile-mode" ; Major mode for editing Dockerfile
        "emacs-swiper" ; Isearch with an overview
        "emacs-emacsql" ; Emacs high-level SQL database front-end 
        ; "emacs-helm-cider" ; Helm interface to Clojure's CIDER 
        ; (daym) TODO emacs-graphviz-dot-mode
        "emacs-jinja2-mode" ; Major mode for jinja2 
        "emacs-org-fc" ; Spaced repetition system for Emacs Org mode 
        "emacs-org-vcard" ; Org mode support for vCard export and import 
        "emacs-vundo" ; Visualize the undo tree 
        "emacs-wttrin" ; Frontend for weather web service `wttr.in' 
        "emacs-org-re-reveal" ; Build HTML presentations with reveal.js from Org source files 
        "emacs-frames-only-mode" ; Use frames instead of Emacs windows 
        "emacs-popper" ; Emacs minor-mode to summon and dismiss buffers easily 
        ; (daym) TODO avy
        ; (daym) doesn't native compile: emacs-mastodon
        "emacs-elfeed" ; Atom/RSS feed reader for Emacs 
        "emacs-elfeed-score" ; Gnus-style scoring for Elfeed 
        "emacs-elfeed-org" ; Configure Elfeed with an Org-mode file 
        "emacs-fortran-tags" ; Emacs plugin for source code indexing of modern Fortran 
        ; (daym) or celluloid for gtk
        "emacs-mpv" ; Control MPV for easy note taking 
        "emacs-empv" ; Emacs multimedia player, media library manager, YouTube frontend 
        ; emacs-ytel ; Youtube front-end for Emacs 
        "emacs-nov-el" ; Major mode for reading EPUBs in Emacs 
        "dvisvgm" ; Command-line utility for generating SVG from DVI, EPS and PDF files 
        "emacs-ztree" ; Directory tree comparison mode for Emacs 

        ; (daym) Guile IDE
        "emacs-arei" ; Asynchronous Reliable Extensible IDE 
        "guile-ares-rs" ; Asynchronous Reliable Extensible Sleek RPC Server for Guile 
        "tree-sitter-tlaplus" ; Tree-sitter TLA+ grammar 
        "emacs-org-sticky-header" ; Always show current org header line 
        "pandoc" ; Conversion between markup formats
        "emacs-pandoc-mode" ; Minor mode for interacting with Pandoc 
        "emacs-ox-pandoc" ; Org exporter for Pandoc 
        "emacs-org-pandoc-import" ; Read and edit non-Org file types in Org 
        "emacs-org-auto-tangle" ; Automatically tangle code blocks on save 
        "emacs-howm" ; Note-taking tool for Emacs 
        "emacs-pdf-tools" ; Emacs support library for PDF files
        "emacs-ripgrep" ; Search using ripgrep from inside Emacs
        "emacs-deadgrep" ; Frontend for `ripgrep'
        "emacs-hydra" ; Make Emacs bindings that stick around
        "emacs-exec-path-from-shell" ; Get environment variables such as `PATH' from the shell


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
    (list
        (emacs-spacious-padding-patch (specification->package "emacs-spacious-padding")) ; Increase the padding or spacing of frames and windows
        ; (daym) Used by emacs-dap-mode
        ; (patch2 (specification->package "emacs-lsp-treemacs")) ; Integration between LSP mode and treemacs 
        ; (patch2 (specification->package "emacs-dap-mode")) ; Emacs client/library for Debug Adapter Protocol 
        ; (patch2 (specification->package "emacs-lsp-mode")) ; Emacs client and library for the Language Server Protocol
        ; (patch2 (specification->package "emacs-lsp-ui")) ; User interface extensions for `lsp-mode'
        ; (daym) doesn't work emacs-lsp-docker
        ; (daym) part of emacs since emacs 29 emacs-csharp-mode
        ; (patch2 (specification->package "emacs-ccls")) ; Emacs support for the `ccls' language server ;  C LSP; conflicts with our patched dap-mode
        ; (patch2 (specification->package "emacs-lsp-java")) ; Java support for lsp-mode ; (daym) conflicts with our patched dap-mode
        ; (patch2 (specification->package "emacs-company-lsp")) ; Completion for `lsp-mode' 
        ; (patch2 (specification->package "emacs-consult-lsp")) ; (daym) gcc 4.9 build failure
    )
  )
)
