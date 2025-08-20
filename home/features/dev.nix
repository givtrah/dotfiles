{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
  vscode
  yarn
  opencode

      #  devenv # for python development (any..) 
  direnv 


  ];



}
