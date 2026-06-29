{ config, pkgs, ... }:
{

  programs.bash = {
    enable = true;
    enableCompletion = true;
    blesh = true;
  
    shellAliases = {
    nboot = "sudo nixos-rebuild boot --flake . --impure";
    nswitch = "sudo nixos-rebuild switch --flake . --impure";
    nsgc = "sudo nix-store --gc";
    ngc = "sudo nix-collect-garbage -d";
    ngc7 = "sudo nix-collect-garbage --delete-older-than 7d";
    ngc14 = "sudo nix-collect-garbage --delete-older-than 14d";
    
    cat = "bat --paging=never";
    ls = "eza";
    z = "zoxide";

    vi = "nvim"; # yes!
    sudo = "sudo "; # fix aliases not working with sudo - the space means carry over aliases


    # ripgrep = "grep";

    };

    initExtra = ''
      export PATH="$HOME/.cache/.bun/bin:$PATH"
      '';
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
      lua.disabled = true;
      python.disabled = true;
      golang.disabled = true;
      rlang.disabled = true;
      rust.disabled = true;

    };
  };

}
