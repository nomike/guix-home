(define-module (modules basic-shell-tools)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix transformations)
  #:export (basic-shell-tools-packages))


(define-public basic-shell-tools-packages
  (append
   (specifications->packages
    (list
     ;; "ansible" ; currently broken due to locales
     ;; "ansible-lint" ; no such package 
     "audacity" ; 
     "cabextract"              ; 
     "cmake"                   ; 
     "curl"                    ; 
     "daemonize"               ; 
     "dconf-editor"            ; 
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
     ;; "keepass2" ; 
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
     ;; "npm" ; 
     "nss-certs"                     ;
     ;; "openscad" ; 
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
     ;; "rpi-imager" ;
     "ripgrep" ; Line-oriented search tool and Rust successor to `grep'
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
     "thefuck"                      ; 
     "tig"                          ; 
     "trash-cli"                    ; 
     ;; "ttf-mscorefonts-installer" ; 
     ;; "udisks2" ; 
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
     "yt-dlp"                       ; 
     "zsh"                          ; 
     ;; "zsh-antigen" ; no such package
     ))))
