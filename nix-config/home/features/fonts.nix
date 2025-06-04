{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [

  font-awesome
  google-fonts
  corefonts
  vistafonts
#  nerdfonts
  nerd-fonts.jetbrains-mono

  ];


}
