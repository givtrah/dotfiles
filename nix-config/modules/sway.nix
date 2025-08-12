{ pkgs, ... }:
{
  # needed for sway to work, might interfere with other things?
  security.polkit.enable = true;

 environment.systemPackages = with pkgs; [
    # all included using home-manager now
    #    grim # screenshot functionality
    #slurp # screenshot functionality
    #wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    #mako # notification system developed by swaywm maintainer
  ];   


  # enable Sway window manager - done in home manager
  #  programs.sway = {
  #  enable = true;
  #  wrapperFeatures.gtk = true;
  # };

}
