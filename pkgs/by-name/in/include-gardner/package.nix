{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  boost,
  doxygen,
  graphviz,
  gtest,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "include-gardner";
  version = "1.1.0";
  src = fetchFromGitHub {
    owner = "portalmaster137";
    repo = "include_gardener";
    rev = "v${finalAttrs.version}";
    hash = "sha256-b7VaPZSvssNcG2UCMcyVga5ccM8NwS1F7MCQoE027qw=";
  };

  meta = {
    description = "a small C++ based commandline-tool which analyzes include statements in C/C++ code.";
    homepage = "https://github.com/portalmaster137/include_gardener";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ "portalmaster137" ];
    platforms = lib.platforms.unix;
    mainProgram = "include_gardener";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    boost
    doxygen
    graphviz
    gtest
  ];

  configurePhase = ''
    mkdir -p build
    cd build
    cmake ..
  '';

  buildPhase = ''
    make -j$NIX_BUILD_CORES
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp include_gardener $out/bin/
  '';

})
