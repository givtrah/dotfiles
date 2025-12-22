{ config, pkgs, ... }:
{

  # various dependencies for LazyVIM
  #
  home.packages =
    with pkgs;

    [
      wl-clipboard
      git
      lazygit
      curl
      fzf
      ripgrep
      fd

      lynx

#      tree-sitter

      go
      gofumpt
      gotools
      delve

      # dap

      mermaid-cli

      nixfmt-rfc-style

      sqlite

      fish
      lua
      luaPackages.tiktoken_core
      julia-bin
      jdk

      php
      phpPackages.composer

      radian

      (python3.withPackages (ps: with ps; [ pip ipython ]))
      #      python3Packages.pip

      ghostscript
      (texlive.combine { inherit (texlive) scheme-tetex latexmk; })
      biber
    ];

}
