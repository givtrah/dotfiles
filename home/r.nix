{ config, lib, pkgs, inputs, ...}: 

let 
  # Custom package compilation from GitHub
  getColorout = rPkgs: rPkgs.buildRPackage {
    pname = "colorout";
    version = "1.3-3";
    src = pkgs.fetchFromGitHub {
      owner = "jalvesaq";
      repo = "colorout";
      rev = "v1.3-3";
      sha256 = "sha256-1aWDrvW1+X5bxJEZlm3RLy8Urx6UlYX7BqJwNF2bNYA=";
    };
  };

  # Unstable R package set
  myRPackages = (with pkgs.rPackages; [
    tidyverse
    pastecs
    jtools
    huxtable
    officer
    tableone
    data_table
    ggvenn
    ggpubr
    Hmisc
    limma
    KEGGREST
    COMBAT
    S4Vectors
    GEOquery
    HDF5Array
    mogene10sttranscriptcluster_db
    mogene11sttranscriptcluster_db

    # Tooling
    languageserver
    httpgd
    rlang
    readxl
  ]) ++ [ (getColorout pkgs.rPackages) ];

  # Unstable R binary wrapper managing compiled libraries
  myR = pkgs.rWrapper.override {
    packages = myRPackages;
  };

  # Import the standalone source derivation
  customRStudio = import ./rstudio-custom.nix {
    inherit pkgs myR;
  };

in {
  home.packages = [
    myR
#    customRStudio
  ];

  home.file.".Rprofile".source = ./Rprofile;
}

