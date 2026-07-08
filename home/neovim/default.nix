{ config, pkgs, username, ... }:{
  
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
      gopls # Go
		  lua-language-server # lua
      marksman # Markdown
			pyright # python
      rust-analyzer # rust
			tinymist # typst
      typescript-language-server
      yaml-language-server # YAML

			# rPackages.languageserver # R
      
#      (rWrapper.override {
#        packages = with rPackages; [ languageserver ];
#      })

      # Treesitter bindings
      # vimPlugins.nvim-treesitter-parsers.r


      # 
      tree-sitter

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

    extraLuaPackages = ls: with ls; [ 
    luarocks 

    ];
  };
  # Symlinks ./nvim folder directly into ~/.config/nvim
#  xdg.configFile."nvim".source = ./nvim;

#home.file."/home/{$username}/.config/nvim".source =
#config.lib.file.mkOutOfStoreSymlink
#    "${config.home.homeDirectory}/.dotfiles/home/neovim/nvim";

  xdg.configFile.nvim = { source = ./nvim; recursive = true;};


}
