{ config, pkgs, ... }:
{

  programs.bash = {
    enable = true;
  };

  programs.bash.shellAliases = {
    nswitch = "sudo nixos-rebuild switch --flake . --impure";
    nsgc = "sudo nix-store --gc";
    ngc = "sudo nix-collect-garbage -d";
    ngc7 = "sudo nix-collect-garbage --delete-older-than 7d";
    ngc14 = "sudo nix-collect-garbage --delete-older-than 14d";
    
    cat = "bat --paging=never";
    ls = "eza";
    z = "zoxide";

    # ripgrep = "grep";



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
