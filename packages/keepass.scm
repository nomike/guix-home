;;; Copyright © 2026 nomike Postmann <nomike@nomike.com>
(define-module (packages keepass)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system go)
  #:use-module (guix build-system hare)
  #:use-module (guix build-system pyproject)
  #:use-module (guix build-system python)
  #:use-module (guix build-system qt)
  #:use-module (guix build-system trivial)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages aidc)
  #:use-module (gnu packages authentication)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages cryptsetup)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages digest)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages dotnet)
  #:use-module (gnu packages file)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-build)
  #:use-module (gnu packages golang-crypto)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages golang-web)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages hare-xyz)
  #:use-module (gnu packages image)
  #:use-module (gnu packages kerberos)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages man)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages nettle)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages opencl)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages rdesktop)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages ruby-xyz)
  #:use-module (gnu packages security-token)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages web)
  #:use-module (gnu packages wxwidgets)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages xml))

(define-public keepass
  (package
    (name "keepass")
    (version "2.61")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "mirror://sourceforge/keepass/KeePass%202.x/"
                           version "/KeePass-" version "-Source.zip"))
       (sha256
        (base32 "1dj45lhy2l22xdf7q031clf894xfigaxcqg5bw3747y59lcz0x51"))))
    (build-system gnu-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (replace 'unpack
            (lambda* (#:key source #:allow-other-keys)
              (mkdir "source")
              (chdir "source")
              (invoke "unzip" source)))
          (replace 'configure
            (lambda* (#:key inputs #:allow-other-keys)
              (substitute* "KeePassLib/Native/NativeMethods.Unix.cs"
                (("libgcrypt.so.20|libglib-2.0.so.0|libgtk-3.so.0" all)
                 (search-input-file inputs
                                    (string-append "/lib/" all))))
              (substitute* "KeePass.sln"
                (("GlobalSection\\(ExtensibilityGlobals\\).*?EndGlobalSection")
                 "")
                (("GlobalSection\\(ExtensibilityGlobals\\).*?EndGlobalSection"
                  all)
                 "")
                (("Format Version 10\\.0")
                 "Format Version 11.00"))
              (substitute* "KeePass/KeePass.csproj"
                ((" ToolsVersion=\\\"3\\.5\\\"")
                 " ToolsVersion=\"4.0\"")
                (("<SignAssembly>true</SignAssembly>")
                 "<SignAssembly>false</SignAssembly>")
                ;; XML Serializer AOT compiler doesn't work here.
                ;; mono will just fall back to the runtime compiler.
                (("[$][(]FrameworkSDKDir[)]bin.sgen[.]exe")
                 "echo"))
              (copy-file "Ext/Icons_15_VA/LowResIcons/KeePass_LR.ico"
                         "KeePass/KeePass.ico")
              (copy-file "Ext/Icons_15_VA/LowResIcons/KeePass_LR.ico"
                         "KeePass/IconsKeePass.ico")
              (copy-file "Ext/Icons_15_VA/LowResIcons/KeePass_LR_G.ico"
                         "KeePass/IconsKeePass_G.ico")
              (copy-file "Ext/Icons_15_VA/LowResIcons/KeePass_LR_R.ico"
                         "KeePass/IconsKeePass_R.ico")
              (copy-file "Ext/Icons_15_VA/LowResIcons/KeePass_LR_Y.ico"
                         "KeePass/IconsKeePass_Y.ico")
              (substitute* "KeePassLib/KeePassLib.csproj"
                ((" ToolsVersion=\\\"3\\.5\\\"")
                 " ToolsVersion=\"4.0\"")
                (("<SignAssembly>true</SignAssembly>")
                 "<SignAssembly>false</SignAssembly>"))
              (substitute* "Translation/TrlUtil/TrlUtil.csproj"
                ((" ToolsVersion=\\\"3\\.5\\\"")
                 " ToolsVersion=\"4.0\""))
              (copy-file "Ext/Icons_15_VA/LowResIcons/KeePass_LR.ico"
                         "KeePass/Resources/KeePass.ico")))
          (delete 'patch-source)
          (replace 'build
            (lambda* (#:key outputs #:allow-other-keys)
              (setenv "MONO_REGISTRY_PATH" "/dev/null")
              (setenv "LANG" "C")
              (setenv "LC_ALL" "C")
              (invoke "xbuild"
                      "KeePass.sln"
                      "/target:KeePass"
                      "/property:Configuration=Release"
                      "/property:CscToolExe=mcs"
                      "/verbosity:diagnostic")))
          (replace 'install
            (lambda* (#:key inputs #:allow-other-keys)
              (let* ((script (string-append #$output "/bin/keepass"))
                     (mono (assoc-ref inputs "mono"))
                     (lib (string-append #$output "/lib/keepass")))
                (install-file "KeePass/obj/Release/KeePass.exe" lib)
                (install-file "Ext/KeePass.config.xml" lib)
                (mkdir (string-append #$output "/bin"))
                (call-with-output-file script
                  (lambda (port)
                    (format port
                     "#!/bin/sh
exec ~s/bin/mono ~s/lib/keepass/KeePass.exe \"$@\"
" mono
                     #$output)))
                (chmod script #o755)
                (patch-shebang script)))))
      #:tests? #f)) ;no tests
    (native-inputs (list unzip icoutils))
    (inputs (list mono libgdiplus libgcrypt glib gtk+))
    (home-page "https://keepass.info/")
    (synopsis "Light-weight and easy-to-use password manager")
    (description
     "KeePass is a light-weight and easy-to-use password manager that helps
you manage your passwords in a secure way.  All passwords are stored
in an encrypted database, which is locked with a master key or key file.")
    (license license:gpl2)))
