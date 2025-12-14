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

		rmapi # remarkable interface
    qbittorrent

    telegram-desktop
    kdePackages.kcalc
    
#    legcord      # uses electron! (electron-unwrapped)
  obsidian
#  jellyfin-media-player # insecure 2025-08-30 since it uses qtwebengine 5.15.19 based on old chromium
  mesa-demos # includes everything in glxinfo
#  zoom-us
#  teams-for-linux
  vulkan-tools
  adwaita-icon-theme
#  steam-run 
  v4l-utils
#  guvcview
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
  maestral-gui

      # Videorip encoding etc.
  mkvtoolnix
  



  ]

 ++
  # packages not available on aarch64 goes here 
    (if (pkgs.stdenv.hostPlatform.system == "aarch64-linux")
    then [ zotero-nix.packages.aarch64-linux.default]
  else
    (if (pkgs.stdenv.hostPlatform.system == "x86_64-linux")
      then [ makemkv zotero-beta zoom-us steam-run zettlr nomachine-client calibre 

    upscayl  # AI upscaler
        ]
      else []));

# teams-for-linux

}
