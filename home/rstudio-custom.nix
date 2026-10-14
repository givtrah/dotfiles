{ pkgs, myR }:

let
  dtlSrc = pkgs.fetchFromGitHub {
    owner = "cubicdaiya";
    repo = "dtl";
    rev = "v1.21";
    sha256 = "sha256-67HT2JT0kPXqzCfcgtfRZZ/zM35ZWULb0ooCjagzr3w=";
  };

  # GoogleTest dependency required by RStudio's CMake structure
  gtestSrc = pkgs.fetchFromGitHub {
    owner = "google";
    repo = "googletest";
    rev = "release-1.12.1";
    sha256 = "sha256-W+OxRTVtemt2esw4P7IyGWXOonUN5ZuscjvzqkYvZbM=";
  };

  # Fetch MathJax 2.7 release archive required by RStudio build scripts
  mathjax27Src = pkgs.fetchzip {
    url = "https://s3.amazonaws.com/rstudio-buildtools/mathjax-27.zip";
    sha256 = "sha256-J7SZK/9q3HcXTD7WFHxvh++ttuCd89Vc4SEBrUEU0AI="; # Nix will output the correct hash on build
  };


  # Fetch MathJax 4 archive required by this release tag
  mathjaxSrc = pkgs.fetchzip {
    url = "https://s3.amazonaws.com/rstudio-buildtools/mathjax-4.zip";
    sha256 = "sha256-p0d4qXx/QXxstoik/a0rpTD+1zs7Ua+BfwKiZwniIYc="; # Nix will output the correct hash on build
  };

  # Fetch Hunspell core dictionaries archive
  dictionariesSrc = pkgs.fetchzip {
    url = "https://s3.amazonaws.com/rstudio-buildtools/dictionaries/core-dictionaries.zip";
    sha256 = "sha256-p0d4qXx/QXxstoik/a0rpTD+1zs7Ua+BfwKiZwniIYc="; # Nix will output the correct hash on build
    stripRoot = false;
  };

quartoSrc = pkgs.fetchzip {
    url = "https://github.com/quarto-dev/quarto-cli/releases/download/v1.4.555/quarto-1.4.555-linux-amd64.tar.gz";
    sha256 = "sha256-++I7SpDdC9cFZESkHFB32GR70XXIS9553huB0zTAUEI="; # Nix will output the correct hash on build
  };

# Copilot language server JavaScript bundle required by CMake session targets
  copilotSrc = pkgs.fetchzip {
    url = "https://s3.amazonaws.com/rstudio-buildtools/copilot-language-server/1.551.2/copilot-language-server-js-1.551.2.zip";
    sha256 = "sha256-wDV1F8rzO49sp2XxcZdvwyWKSzu+2CWahZ2kLoVoGRE="; # Nix will output the correct hash on build
    stripRoot = false;
  };





in pkgs.stdenv.mkDerivation {
  pname = "rstudio-desktop-custom";
  version = "2026.09.0-174";

  src = pkgs.fetchFromGitHub {
    owner = "rstudio";
    repo = "rstudio";
    rev = "v2026.09.0+174";
    sha256 = "sha256-67HT2JT0kPXqzCfcgtfRZZ/zM35ZWULb0ooCjagzr3w=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    makeWrapper
    qt6.wrapQtAppsHook
    ant
    jdk11
    git
  ];

  buildInputs = with pkgs; [
    myR
    boost
    openssl
    zlib
    icu
    libpqxx
    soci
    yaml-cpp
    gtk3
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwebengine
    qt6.qtsensors
    qt6.qtsvg
  ];


postPatch = ''
    # Replace package/linux/CMakeLists.txt with a clean stub
    cat << 'EOF' > package/linux/CMakeLists.txt
    # Stub out packaging sub-targets for Nix builder
    message(STATUS "Overriding package/linux/CMakeLists.txt for Nix sandbox")
    EOF
  '';

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DRSTUDIO_TARGET=Desktop"
    "-DRSTUDIO_SERVER=OFF"
    "-DRSTUDIO_PACKAGE_BUILD=OFF"
    "-DRSTUDIO_INSTALL_SUPPORT=OFF"
    "-DLIBR_HOME=${myR}/lib/R"
    "-DLIBR_CORE=${myR}/lib/R/lib"
    "-DRSTUDIO_USE_SYSTEM_SOCI=ON"
    "-DRSTUDIO_USE_SYSTEM_BOOST=ON"
    "-DRSTUDIO_USE_SYSTEM_YAML_CPP=ON"
    "-DFETCHCONTENT_FULLY_DISCONNECTED=ON"
    "-DFETCHCONTENT_SOURCE_DIR_DTL=${dtlSrc}"
    "-DRSTUDIO_NOTIFY_UPDATES=OFF"
    "-DRSTUDIO_BUILD_TESTS=OFF"
  ];

  preConfigure = ''
    # Provide gtest directory expected by CMake
    mkdir -p src/cpp/tests/cpp/tests/vendor/gtest
    cp -r ${gtestSrc}/* src/cpp/tests/cpp/tests/vendor/gtest/

    # Unpack and position MathJax 2.7 bundle
    mkdir -p dependencies/mathjax-27
    cp -r ${mathjax27Src}/* dependencies/mathjax-27/

    # Unpack and position MathJax 4 bundle
    mkdir -p dependencies/mathjax-4
    cp -r ${mathjaxSrc}/* dependencies/mathjax-4/

    # Unpack and position Hunspell dictionaries bundle
    mkdir -p dependencies/dictionaries
    cp -r ${dictionariesSrc}/* dependencies/dictionaries/

    # Populate Quarto toolchain
    mkdir -p dependencies/quarto
    cp -r ${quartoSrc}/* dependencies/quarto/

    # Populate GitHub Copilot language server
    mkdir -p dependencies/copilot-language-server-js
    cp -r ${copilotSrc}/* dependencies/copilot-language-server-js/

  '';

  qtWrapperArgs = [
    "--prefix PATH : ${myR}/bin"
    "--set RSTUDIO_WHICH_R ${myR}/bin/R"
  ];

  meta = with pkgs.lib; {
    description = "RStudio Desktop compiled natively from source tag v2026.09.0+174";
    homepage = "https://github.com/rstudio/rstudio";
    license = licenses.agpl3Only;
    platforms = platforms.linux;
  };
}
