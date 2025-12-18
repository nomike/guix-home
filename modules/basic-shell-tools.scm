(define-module (modules basic-shell-tools)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix transformations)
  #:use-module (guix inferior)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1))

(define patch-ytdlp-xhamster
  (options->transformation `((with-patch . ,(string-append "yt-dlp="
                                                           "patches/yt-dlp-xhamster.patch")))))

;; Define channels for old Guix version with working telegram-desktop
;; https://codeberg.org/guix/guix/issues/2815
(define telegram-channels
  (list (channel
         (name 'guix)
         (url "https://git.guix.gnu.org/guix.git")
         (commit "464c3b63401f213a13870146f4e592734972b54b"))))

(define-public basic-shell-tools-packages
  (append
   (specifications->packages
    (list
     ;; "ansible" ; currently broken due to locales
     ;; "ansible-lint" ; no such package 
     "audacity" ; 
     "cabextract"              ; 
    ;  "cmake"                   ; 
     "curl"                    ; 
     "daemonize"               ; 
     "dconf-editor"            ;
     "diffoscope" ; Compare files, archives, and directories in depth
     "diffstat"                ; 
     "diffutils"               ; 
     "dos2unix"                ; 
     "dosfstools"              ; 
     ;; "easy-rsa" ; no such package
     ;; "element-desktop" ; 
     ;; "emacs" ; 
     ;; "exfat-fuse" ; no such package
     "exfatprogs"              ; 
     "feh"                     ; 
     ;; "finger" ; no such package
     ;; "flatpak" ; 
     ;; "fonts-liberation" ; no such package
     ;; "fonts-powerline" ; no such package
     "gdb"                              ; 
     "ddrescue"                         ; 
     "gimp" ; 
     "git"
     "git:gui"
     "git:send-email"
     ;; "gitk" ;
     "glew"
     ;; "gnome-browser-connector" ; 
     ;; "gnome-shell-extension-manager" ; 
     ;; "gnome-software" ; 
     ;; "gnome-tweaks" ; 
     ;; "gnome-weather" ;
     "gnupg" ; GNU Privacy Guard
     ;; "google-android-platform-tools-installer" ;
     "gparted" ; 
     ;; "graphicsmagick-imagemagick-compat" ; no such package
     ;; "guake" ; no such package
     ;; "guix" ; 
     ;; "handbrake" ; 
     ;; "handbrake-cli" ; 
     ;; "hexchat" ; 
     "htop"   ;
     ;; "intel-one-mono" ; Expressive monospaced font family 
     "httping"         ; 
     "inkscape" ; 
     ;; "ipython3" ; 
     "jq"              ; 
     "jupp" ; 
     "keepass" ; Light-weight and easy-to-use password manager
     ;; "landscape-common" ; 
     ;; "libfuse2" ; no such package
     ;; "libimage-exiftool-perl" ; no such package
     ;; "libreoffice-java-common" ; 
     ;; "logstalgia" ;
     "meld"            ; Compare files, directories and working copies
     "mc"              ; 
     "minicom"         ; 
     ;; "mono-complete" ; 
     ;; "mplayer" ; 
     "mtools"                        ; 
     "mumi"                          ; 
     ;; "ncal" ; no such packeter
     "ncdu"                          ; 
     "net-tools"                     ; 
     "nmap"                          ; 
     "node"                          ; Evented I/O for V8 JavaScript
     ;; "npm" ; 
     "nss-certs"                     ;
    ;  "openscad" ; 
     ;; "openjdk-11-jdk" ; 
     ;; "openjdk-11-jre" ; 
     ;; "openjdk-17-jdk" ; 
     ;; "openjdk-17-jre" ; 
     ;; "openshot-qt" ; 
     ;; "openssh-server" ; 
     ;; "p7zip-full" ; 
     "pavucontrol"                   ; 
     ;; "pipx" ; 
     ;; "playonlinux" ; 
     ;; "plocate" ; 
     ;; "printer-driver-gutenprint" ; 
     "pwgen"   ; 
     ;; "python3-autopep8" ; 
     ;; "python3-crcmod" ; 
     ;; "python3-docopt" ; 
     ;; "python3-pip" ; 
     ;; "python3-venv" ; 
     ;; "python3-virtualenv" ; 
     ;; "qdirstat" ; 
     "rename" ; Perl extension for renaming multiple files
     "ripgrep" ; Line-oriented search tool and Rust successor to `grep'
     ;; "rpi-imager" ;
     "screen" ; Full-screen window manager providing multiple terminals
     "sl"     ; 
     ;; "smartmontools" ; 
     "socat"                        ; 
     ;; "solaar" ; 
     "sox"                          ; 
     ;; "ssh-askpass-gnome" ; 
     "sshfs"                        ; 
     ;; "syncthing" ; 
     ;; "system-config-printer" ; 
     "tcpdump"                      ;
     ;; "telegram-desktop" ; Telegram Desktop - using inferior instead
     "thefuck"                      ; 
     "tig"                          ;
     "tmux" ; Terminal multiplexer
     "trash-cli"                    ; 
     ;; "ttf-mscorefonts-installer" ;
     "tuxpaint" ; Drawing software for children
     ;; "udisks2" ; 
     "ungoogled-chromium-wayland" ; Graphical web browser
     "unzip"                        ; 
     ;; "virt-manager" ; 
     ;; "vlc" ; 
     ;; "vorta" ;
     "waypipe" ; Proxy for Wayland protocol applications
     "wget"                         ; 
     "whois"                        ; 
     ;; "wireshark" ; 
     "xclip"                        ; 
     ;; "yamllint" ; no such package
    ;  "yt-dlp"
     "zsh"                          ; 
     ;; "zsh-antigen" ; no such package
     ))
   (list
    ; (patch-ytdlp-xhamster (specification->package "yt-dlp"))
    ;; Get telegram-desktop from older Guix version
    ;; https://codeberg.org/guix/guix/issues/2815
    (let ((inferior (inferior-for-channels telegram-channels)))
      (first (lookup-inferior-packages inferior "telegram-desktop")))))))
