{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
  vscode
  yarn

  devenv # for python development (any..) 
  direnv 


  ];



}
