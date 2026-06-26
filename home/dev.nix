{ config, pkgs, ...}: {

  home.packages = with pkgs; 

  [
  vscode
  yarn
# install via bun instead # opencode 

  devenv # for python development (any..) 
  direnv 

  nodejs
  bun

  ];



}
