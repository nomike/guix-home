(define-module (packages prusa-slicer-2-9-1)
  #:use-module (gnu packages tbb)
  #:use-module (gnu packages wxwidgets)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages image)
  #:use-module (gnu packages engineering)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages check)
  #:use-module (gnu packages boost)
  #:use-module (gnu home)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix transformations)
  #:use-module (guix build-system cmake)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (psua-slicer-2-9-1-package))


(define-public prusa-slicer-2-9-1-package
 (package
    (name "prusa-slicer")
    (version "2.9.1")
    (source
     (origin
       (method git-fetch)
       (uri
        (git-reference
         (url "https://github.com/prusa3d/PrusaSlicer")
         (commit (string-append "version_" version))))
       (file-name (git-file-name name version))
       (sha256 (base32 "1jxjx1yaknwphdvnh08r3srizpwb908ji8180plh05dzdp8wzpcb"))
      ;  (patches (search-patches "prusa-slicer-fix-tests.patch"))
       (modules '((guix build utils)))
       (snippet
        `(begin
           ;; Prusa slicer bundles a lot of dependencies in src/ directory.
           ;; Most of them contain prusa-specific modifications (e.g. avrdude),
           ;; but others do not. Here we replace the latter with Guix packages.
           ;; Remove bundled libraries that were not modified by Prusa Slicer developers.
          ;  (delete-file-recursively "src/hidapi")
          ;  (delete-file-recursively "src/eigen")
          ;  (delete-file-recursively "src/libigl/igl")
          ;  (substitute* "CMakeLists.txt"
          ;    (("add_library\\(libexpat INTERFACE\\)")
          ;     ""))
          ;  (substitute* "src/libigl/CMakeLists.txt"
          ;    (("target_link_libraries\\(libigl INTERFACE igl::core\\)") ""))
           (substitute* "src/CMakeLists.txt"
             (("add_subdirectory\\(hidapi\\)")
              "pkg_check_modules(HIDAPI REQUIRED hidapi-hidraw)")
             (("include_directories\\(hidapi/include\\)")
              "include_directories()"))
           (substitute* "src/slic3r/CMakeLists.txt"
             (("add_library\\(libslic3r_gui.*" all)
              (string-append
               all
               "\ntarget_include_directories(libslic3r_gui PUBLIC ${HIDAPI_INCLUDE_DIRS})\n"))
             (("\\bhidapi\\b") "${HIDAPI_LIBRARIES}"))))))
    (build-system cmake-build-system)
    (arguments
     (list #:configure-flags
           #~(list "-DSLIC3R_FHS=1" ;; Use The Filesystem Hierarchy Standard.
                  ;  "-DSLIC3R_GTK=3" ;; Use GTK+
                  ;  ;; Use wxWidgets 3.0.x.x to prevent GUI crashes when adding support enforcers.
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
                      "#include <igl/qslim.h>")))))))
    (native-inputs
     (list pkg-config catch2))
    (inputs
     (list boost
           cereal
           cgal
           curl
           dbus
           eigen
           eudev
           expat
           glew
           glib
           gmp
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
           nlopt
           opencascade-occt
           openvdb
           pango
           prusa-libbgcode
           ;; XXX: Using Prusa wxWidgets fork as PrusaSlicer segfaults when compiled
           ;; with regular wxwidgets.
           prusa-wxwidgets
           qhull
           tbb
           zlib))
    (home-page "https://www.prusa3d.com/prusaslicer/")
    (synopsis "G-code generator for 3D printers (RepRap, Makerbot, Ultimaker etc.)")
    (description "PrusaSlicer takes 3D models (STL, OBJ, AMF) and converts them into
G-code instructions for FFF printers or PNG layers for mSLA 3D printers.")
    (license license:agpl3)

    ;; Mark as tunable to take advantage of SIMD code in Eigen and in libigl.
    (properties '((tunable? . #t)))))
