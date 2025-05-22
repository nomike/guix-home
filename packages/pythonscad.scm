(define-module (packages pythonscad)
  #:use-module (packages openscad)
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
  #:use-module (gnu packages curl)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages libcanberra)
  #:use-module (gnu packages engineering)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages image)
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
  #:use-module (gnu packages python)
  #:use-module (gnu packages nettle)
  #:use-module (gnu home)
  #:use-module (guix packages)
  #:use-module (gnu packages)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix transformations)
  #:use-module (guix build-system qt)
  #:use-module (guix utils)
  #:use-module ((guix licenses) #:prefix license:)
  #:export (pythonscad))

(define-public pythonscad
  (let ((commit "b856456fcf26e089a616e5a9b5d685b8a8f2e2c1")
        (version "2025.05.21")
        (revision "0"))
   (package
    (inherit openscad)
    (name "pythonscad")
    (version (git-version "0.0.0" revision commit))
    (source
     (origin
      (method git-fetch)
      (uri (git-reference
            (url "https://github.com/pythonscad/pythonscad")
            (commit commit)
            (recursive? #t)))
      (sha256
       (base32 "0bjpvj94m3kplpnmnlai7mjx45d5acnqw943w3p1mprg8wrp3ap6"))
      (file-name (git-file-name name version))))
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
                "-DPYTHON_VERSION=3.11" ; TODO: #$(package-version (this-package-input "python")) but ditch the sub-version
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
                  ;; <https://github.com/openscad/openscad/issues/5897>
                  (("find_package\\(Nettle 3.4\\)")
                   "find_package(Nettle 3.4 REQUIRED)")
                  ;; Use the system sanitizers-cmake module.
                  (("\\$\\{CMAKE_SOURCE_DIR\\}/submodules/sanitizers-cmake/cmake")
                   (string-append (assoc-ref inputs "sanitizers-cmake")
                                  "/share/sanitizers-cmake/cmake"))))))))
    (inputs (modify-inputs (package-inputs openscad)
                           (append libjpeg-turbo curl python nettle))))))
