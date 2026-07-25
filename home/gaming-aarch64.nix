{ config, pkgs, ...}: {



  programs.retroarch = { 
    enable = true;
    cores = {
      puae.enable = true;
      snes9x.enable = true;
    };
  };

  home.packages = with pkgs; 

  # FOR NOW THIS ASSUMES AN X86_X64 HOST!

  [

    rusty-path-of-building # POE1 and POE2 build planner

  ];

}
