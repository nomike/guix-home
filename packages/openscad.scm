(define-module (packages openscad)
  #:use-module (gnu packages base)
  #:use-module (gnu packages tbb)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages c)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages libcanberra)
  #:use-module (gnu packages engineering)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages kde-frameworks)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages nettle)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages bison)
  #:use-module (gnu home)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix transformations)
  #:use-module (guix build-system qt)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (psua-slicer-2-9-1-package))


(define-public openscad
  (let ((commit "c76900f9a62fcb98c503dcc5ccce380db8ac564b")
        (version "2025.05.17")
        (revision "0"))
    (package
      (name "openscad")
      (version (git-version version revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/openscad/openscad")
               (commit commit)
               (recursive? #t)))
         (sha256
          (base32 "1f79kidx82jfi2dh3j7dibar04jbzan2s5c58i9hbfl1kx7zqvs7"))
         (file-name (git-file-name name version))))
      (build-system qt-build-system)
      (arguments
       (list
        #:configure-flags
        #~(list "-DCMAKE_BUILD_TYPE=Release"
                "-DUSE_BUILTIN_OPENCSG=ON"
                "-DMANIFOLD_PYBIND=OFF"
                "-DMANIFOLD_TEST=OFF"
                "-DENABLE_TESTS=OFF"
                "-DEXPERIMENTAL=ON"
                "-DSNAPSHOT=ON"
                "-DENABLE_PYTHON=ON"
                "-DUSE_BUILTIN_CLIPPER2=OFF"
                (string-append "-DOPENSCAD_VERSION="
                               #$version)
                (string-append "-DOPENSCAD_COMMIT="
                               #$commit)
                "-DENABLE_EGL=ON"
                "-DENABLE_GLX=ON")
        #:phases
        #~(modify-phases %standard-phases
            (delete 'check)
            (add-after 'unpack 'patch-source
              (lambda* (#:key inputs #:allow-other-keys)
                ;; <https://github.com/openscad/openscad/issues/5877>
                (substitute* "cmake/Modules/FindLib3MF.cmake"
                  (("PC_LIB3MF_INCLUDE_DIRS")
                   "PC_LIB3MF_INCLUDEDIR"))
                (substitute* "CMakeLists.txt"
                  ;; <https://github.com/openscad/openscad/issues/5880>
                  (("target_link_libraries\\(OpenSCAD PRIVATE OpenGL::EGL\\)")
                   "      find_package(ECM REQUIRED NO_MODULE)
      list(APPEND CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
      find_package(EGL REQUIRED)
      target_link_libraries(OpenSCAD PRIVATE EGL::EGL)")
                  ;; Use the system sanitizers-cmake module.
                  (("\\$\\{CMAKE_SOURCE_DIR\\}/submodules/sanitizers-cmake/cmake")
                   (string-append (assoc-ref inputs "sanitizers-cmake")
                                  "/share/sanitizers-cmake/cmake"))))))))
      (inputs (list boost
                    cairomm
                    cgal
                    clipper2
                    double-conversion
                    eigen
                    egl-wayland
                    fontconfig
                    freetype
                    glew
                    glib
                    gmp
                    harfbuzz
                    hidapi
                    lib3mf
                    libcanberra
                    libspnav
                    libxml2
                    libzip
                    manifold
                    mesa ; or libglvnd if we had mesa-glvnd, too
                    mimalloc
                    mpfr
                    nettle
                    opencsg
                    python-3.12
                    qscintilla
                    qtbase-5
                    qtmultimedia-5
                    qtsvg-5
                    qtwayland-5
                    sanitizers-cmake
                    tbb))
      (native-inputs (list bison
                           extra-cmake-modules
                           flex
                           gettext-minimal
                           pkg-config
                           which
                           xvfb-run
                           ;; the following are only needed for tests
                           imagemagick
                           ghostscript
                           procps
                           python-numpy
                           python-pillow
                           python
                           xorg-server-for-tests))
      (synopsis "Script-based 3D modeling application")
      (description
       "OpenSCAD is a software for creating solid 3D CAD objects.  It is free
software and available for Linux/UNIX, MS Windows and macOS.
Unlike most free software for creating 3D models (such as the famous
application Blender), OpenSCAD focuses on the CAD aspects rather than the
artistic aspects of 3D modeling.  Thus this might be the application you are
looking for when you are planning to create 3D models of machine parts but
probably not the tool for creating computer-animated movies.
OpenSCAD is not an interactive modeler.  Instead it is more like a 3D-compiler
that reads a script file that describes the object and renders the 3D model
from this script file.  This gives you, the designer, complete control over the
modeling process and enables you to easily change any step in the modeling
process or make designs that are defined by configurable parameters.
OpenSCAD provides two main modeling techniques: First there is constructive
solid geometry (aka CSG) and second there is extrusion of 2D outlines.  As the
data exchange format for these 2D outlines Autocad DXF files are used.  In
addition to 2D paths for extrusion it is also possible to read design
parameters from DXF files.  Besides DXF files OpenSCAD can read and create 3D
models in the STL and OFF file formats.")
      (home-page "https://openscad.org/")
      (license license:gpl2+))))


(define-public pythonscad
  (let ((commit "1857a27efb94341debce25442ed2e14fe5d5d1f1")
        (version "2025.05.15")
        (revision "0"))
    (package
      (name "pythonscad")
      (version (git-version version revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/pythonscad/pythonscad")
               (commit commit)
               (recursive? #t)))
         (sha256
          (base32 "077x7s3z65mz6rnrzan3qn06045d2fkqnd6ss6ibw1fhlaypzfbf"))
         (file-name (git-file-name name version))))
      (build-system qt-build-system)
      (arguments
       (list
        #:configure-flags
        #~(list "-DCMAKE_BUILD_TYPE=Release"
                "-DUSE_BUILTIN_OPENCSG=ON"
                "-DMANIFOLD_PYBIND=OFF"
                "-DMANIFOLD_TEST=OFF"
                "-DENABLE_TESTS=OFF"
                "-DEXPERIMENTAL=ON"
                "-DSNAPSHOT=ON"
                "-DENABLE_PYTHON=ON"
                "-DUSE_BUILTIN_CLIPPER2=OFF"
                (string-append "-DOPENSCAD_VERSION="
                               #$version)
                (string-append "-DOPENSCAD_COMMIT="
                               #$commit)
                "-DENABLE_EGL=ON"
                "-DENABLE_GLX=ON")
        #:phases
        #~(modify-phases %standard-phases
            (delete 'check)
            (add-after 'unpack 'patch-source
              (lambda* (#:key inputs #:allow-other-keys)
                ;; <https://github.com/openscad/openscad/issues/5877>
                (substitute* "cmake/Modules/FindLib3MF.cmake"
                  (("PC_LIB3MF_INCLUDE_DIRS")
                   "PC_LIB3MF_INCLUDEDIR"))
                (substitute* "CMakeLists.txt"
                  ;; <https://github.com/openscad/openscad/issues/5880>
                  (("target_link_libraries\\(OpenSCAD PRIVATE OpenGL::EGL\\)")
                   "      find_package(ECM REQUIRED NO_MODULE)
      list(APPEND CMAKE_MODULE_PATH ${ECM_MODULE_PATH})
      find_package(EGL REQUIRED)
      target_link_libraries(OpenSCAD PRIVATE EGL::EGL)")
                  ;; Use the system sanitizers-cmake module.
                  (("\\$\\{CMAKE_SOURCE_DIR\\}/submodules/sanitizers-cmake/cmake")
                   (string-append (assoc-ref inputs "sanitizers-cmake")
                                  "/share/sanitizers-cmake/cmake"))))))))
      (inputs (list boost
                    cairomm
                    cgal
                    clipper2
                    double-conversion
                    eigen
                    egl-wayland
                    fontconfig
                    freetype
                    glew
                    glib
                    gmp
                    harfbuzz
                    hidapi
                    lib3mf
                    libcanberra
                    libspnav
                    libxml2
                    libzip
                    manifold
                    mesa ; or libglvnd if we had mesa-glvnd, too
                    mimalloc
                    mpfr
                    nettle
                    opencsg
                    python-3.12
                    qscintilla
                    qtbase-5
                    qtmultimedia-5
                    qtsvg-5
                    qtwayland-5
                    sanitizers-cmake
                    tbb))
      (native-inputs (list bison
                           extra-cmake-modules
                           flex
                           gettext-minimal
                           pkg-config
                           which
                           xvfb-run
                           ;; the following are only needed for tests
                           imagemagick
                           ghostscript
                           procps
                           python-numpy
                           python-pillow
                           python
                           xorg-server-for-tests))
      (synopsis "Script-based 3D modeling application")
      (description
       "OpenSCAD is a software for creating solid 3D CAD objects.  It is free
software and available for Linux/UNIX, MS Windows and macOS.
Unlike most free software for creating 3D models (such as the famous
application Blender), OpenSCAD focuses on the CAD aspects rather than the
artistic aspects of 3D modeling.  Thus this might be the application you are
looking for when you are planning to create 3D models of machine parts but
probably not the tool for creating computer-animated movies.
OpenSCAD is not an interactive modeler.  Instead it is more like a 3D-compiler
that reads a script file that describes the object and renders the 3D model
from this script file.  This gives you, the designer, complete control over the
modeling process and enables you to easily change any step in the modeling
process or make designs that are defined by configurable parameters.
OpenSCAD provides two main modeling techniques: First there is constructive
solid geometry (aka CSG) and second there is extrusion of 2D outlines.  As the
data exchange format for these 2D outlines Autocad DXF files are used.  In
addition to 2D paths for extrusion it is also possible to read design
parameters from DXF files.  Besides DXF files OpenSCAD can read and create 3D
models in the STL and OFF file formats.")
      (home-page "https://openscad.org/")
      (license license:gpl2+))))
