(define-module (packages prusa-slicer)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages engineering)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages image)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages tbb)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages wxwidgets)
  #:use-module (gnu packages xml)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix transformations)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system cmake)
  #:use-module (guix search-paths)
  #:export (prusa-slicer))

(define-public prusa-slicer
  (package
    (name "prusa-slicer")
    (version "2.9.4")
    (source
     (origin
       (method git-fetch)
       (uri
        (git-reference
         (url "https://github.com/prusa3d/PrusaSlicer")
         (commit (string-append "version_" version))))
       (file-name (git-file-name name version))
       (sha256 (base32 "008rnwld4i59xh8jg7kdqd8x8f2ynk6mbhs4iypqa8jssjpn0afn"))
       (patches (search-patches "prusa-slicer-add-cmake-module.patch"))
       (modules '((guix build utils)))
       (snippet
        `(begin
           ;; Prusa slicer bundles a lot of dependencies in src/ directory.
           ;; Most of them contain prusa-specific modifications (e.g. avrdude),
           ;; but others do not. Here we replace the latter with Guix packages.
           ;; Remove bundled libraries that were not modified by Prusa Slicer developers.
           (delete-file-recursively "bundled_deps/hidapi")
           (delete-file-recursively "bundled_deps/libigl/igl")
           (substitute* "CMakeLists.txt"
             (("target_link_libraries\\(libexpat INTERFACE EXPAT::EXPAT\\)")
              "")
             (("add_library\\(libexpat INTERFACE\\)")
              ""))
           (substitute* "bundled_deps/CMakeLists.txt"
             (("add_subdirectory\\(hidapi\\)")
              ""))
           (substitute* "bundled_deps/libigl/CMakeLists.txt"
             (("target_link_libraries\\(libigl INTERFACE igl::core\\)") ""))
           (substitute* "src/CMakeLists.txt"
             (("add_subdirectory\\(hidapi\\)")
              "pkg_check_modules(HIDAPI REQUIRED hidapi-hidraw)")
             (("include_directories\\(hidapi/include\\)")
              "include_directories()")
            (("add_library\\(libexpat INTERFACE\\)")
            "")
            (("target_link_libraries\\(libexpat INTERFACE EXPAT::EXPAT\\)")
            "")
            (("list\\(APPEND wxWidgets_LIBRARIES libexpat\\)")
            "list(APPEND wxWidgets_LIBRARIES expat)"))
            (substitute* "src/libslic3r/CMakeLists.txt"
            (("libexpat")
            "expat"))
           (substitute* "src/slic3r/CMakeLists.txt"
             (("add_library\\(libslic3r_gui.*" all)
              (string-append
               "find_package(HidAPI REQUIRED)\n"
               all
               "\ntarget_include_directories(libslic3r_gui PUBLIC ${HIDAPI_INCLUDE_DIR})\n"))
             (("    hidapi")
              "    ${HIDAPI_LIBRARY}"))))))
    (build-system cmake-build-system)
    (arguments
     (list #:configure-flags
           #~(list "-DSLIC3R_FHS=1" ;; Use The Filesystem Hierarchy Standard.
                   "-DSLIC3R_GTK=3" ;; Use GTK+
                   ;; Use wxWidgets 3.0.x.x to prevent GUI crashes when adding support enforcers.
                   "-DSLIC3R_WX_STABLE=1"
                   (format #f "-Dlibigl_DIR=~a"
                           (search-input-directory %build-inputs
                                                   "lib/cmake/igl/"))
                   (format #f "-DCatch2_DIR=~a"
                           (search-input-directory %build-inputs
                                                   "lib/cmake/Catch2/")))
           #:phases
           #~(modify-phases %standard-phases
               (add-after 'unpack 'fix-include-paths
                 (lambda _
                   (substitute* "tests/libslic3r/test_quadric_edge_collapse.cpp"
                     (("#include <libigl/igl/qslim.h>")
                      "#include <igl/qslim.h>"))))
;  (add-after 'install 'wrap-program
;     (lambda* (#:key outputs inputs #:allow-other-keys)
;       (let* ((out (assoc-ref outputs "out"))
;              (glib-networking (assoc-ref inputs "glib-networking"))
;              (gio-modules-dir (string-append glib-networking "/lib/gio/modules")))
;         (wrap-program (string-append out "/bin/prusa-slicer")
;           `("GIO_EXTRA_MODULES_DIR" ":" prefix (,gio-modules-dir)))
;         #t)))

                )))
    (native-inputs
     (list pkg-config catch2-3.8))
    (inputs
     (list boost-1.83
           cereal
           cgal
           curl
           dbus
           eigen
           eudev
           expat
           glew
           glib
           glib-networking
           gmp
           gsettings-desktop-schemas
           gtk+
           heatshrink
           hidapi
           ilmbase
           libigl
           libjpeg-turbo
           libpng
           mesa
           mpfr
           nanosvg
           nlohmann-json
           nlopt
           opencascade-occt-7.6.1
           openssl
           openvdb
           pango
           prusa-libbgcode
           ;; XXX: Using Prusa wxWidgets fork as PrusaSlicer segfaults when compiled
           ;; with regular wxwidgets.
           prusa-wxwidgets
           qhull
           tbb
           webkitgtk-for-gtk3
           webkitgtk-with-libsoup2
           z3
           zlib))
    (propagated-inputs (list nss-certs))
    (home-page "https://www.prusa3d.com/prusaslicer/")
    (synopsis "G-code generator for 3D printers (RepRap, Makerbot, Ultimaker etc.)")
    (description "PrusaSlicer takes 3D models (STL, OBJ, AMF) and converts
them into G-code instructions for FFF printers or PNG layers for mSLA 3D
printers.  It is compatible with any modern printer based on the RepRap
toolchain, including all those based on the Marlin, Prusa, Sprinter and
Repetier firmware.  It also works with Mach3, LinuxCNC and Machinekit
controllers.")
    (license license:agpl3)

    ;; Mark as tunable to take advantage of SIMD code in Eigen and in libigl.
    (properties '((tunable? . #t)))))
