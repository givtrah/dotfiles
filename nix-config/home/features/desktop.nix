{ config, pkgs, zotero-nix, ...}: {

  home.packages = with pkgs; 

  [
    lazygit
    fzf
    ripgrep
    fd

    gimp3-with-plugins
#    deskflow

#    amarok
    clementine
    asunder # cd ripper
    lame
#    beets # does not compile 2024-12-29
    kid3

    amdgpu_top
    lact
    piper

    gnome-multi-writer


    qbittorrent

    telegram-desktop
    kdePackages.kcalc
    
#    legcord      # uses electron! (electron-unwrapped)
  obsidian
  jellyfin-media-player
  mesa-demos # includes everything in glxinfo
#  zoom-us
#  teams-for-linux
  vulkan-tools
  adwaita-icon-theme
#  steam-run 
  v4l-utils
  guvcview
#  nerdfonts

  inkscape

  gsmartcontrol
  # productivity / work
  kitty
  kitty-themes
  kitty-img
  starship

#  zettlr
  remmina
#  libsForQt5.kcalc
#  libsForQt5.kate


  # Multimedia
  mpv
  vlc

  maestral 
 # maestral-gui
  ]

 ++
  # packages not available on aarch64 goes here 
    (if (pkgs.system == "aarch64-linux")
    then [ zotero-nix.packages.aarch64-linux.default]
  else
    (if (pkgs.system == "x86_64-linux")
      then [ zotero zoom-us steam-run zettlr nomachine-client calibre 

    upscayl  # AI upscaler
        ]
      else []));

# teams-for-linux

}
