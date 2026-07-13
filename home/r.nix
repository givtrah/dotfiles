{ config, lib, pkgs, inputs, ...}: 

let 

  # Initialize the stable package set for the current system
  pkgsStable = import inputs.nixpkgs-stable {
    system = pkgs.stdenv.hostPlatform.system;
    config = { 
      allowUnfree = true; 
      permittedInsecurePackages = [
        "electron-38.8.4"
      ];
    }; 
  };


  # Compile colorout directly from its GitHub source
  colorout = pkgs.rPackages.buildRPackage {
    name = "colorout";
    src = pkgs.fetchFromGitHub {
      owner = "jalvesaq";
      repo = "colorout";
      rev = "v1.3-3";
      sha256 = "sha256-1aWDrvW1+X5bxJEZlm3RLy8Urx6UlYX7BqJwNF2bNYA=";
    };
  };

  # Define your custom package list using R packages from pkgs
  myRPackages = with pkgs.rPackages; [
    colorout
    tidyverse
    pastecs
    jtools
    huxtable
    officer
    tableone
    data_table
    ggvenn
    ggpubr
    limma
    KEGGREST
    S4Vectors
    GEOquery
    HDF5Array
    mogene10sttranscriptcluster_db
    mogene11sttranscriptcluster_db

    # Needed for neovim integration
    languageserver
    httpgd
    terminalgraphics
  ];

  # Wrap standard R with your configured package list
  R-with-my-packages = pkgs.rWrapper.override {
    packages = myRPackages;
  };

  # Wrap RStudio with your configured package list
  RStudio-with-my-packages = pkgsStable.rstudioWrapper.override {
    packages = myRPackages;
  };

in {
  # Install R packages safely across architectures
  home.packages = [ R-with-my-packages ] 
    ++ lib.optional (pkgs.stdenv.hostPlatform.system == "aarch64-linux" || pkgs.stdenv.hostPlatform.system == "x86_64-linux") RStudio-with-my-packages;

  # Reference your external standalone configuration file cleanly
  home.file.".Rprofile".source = ./Rprofile;
}
