{ config, pkgs, ... }:{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped; # normal neovim from unstable
#    package = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.default;

    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

 #   initLua = builtins.readFile ./nvim-init.lua;
    

    extraPackages = with pkgs; [
      # LANGUAGE SERVERS GOES HERE (NO MASON! YAY)
		  lua-language-server # lua
			pyright # python
			rPackages.languageserver # R
			tinymist # typst

      # Misc stuff that might be needed for dev shit (should prob go somewhere else)
			doq
      sqlite
      cargo
      clang
      cmake
      gcc
      gnumake
      ninja
      pkg-config
      yarn
      sqlite
    ];

    extraLuaPackages = ls: with ls; [ luarocks ];
  };
  # Symlinks ./nvim folder directly into ~/.config/nvim
  xdg.configFile."nvim".source = ./nvim;


}
