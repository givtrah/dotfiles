{ config, pkgs, zotero-nix, ...}: {

  programs.firefox = {
    enable = true;
      languagePacks = [ "en-US" ];
      configPath = "${config.xdg.configHome}/mozilla/firefox";

# Below may be needed for screensharing etc.?
#    preferences = { 
#      "widget.use-xdg-desktop-portal.file-picker" = 1;
#    };
#    override = {
#      pipewireSupport = true;
#    };
  };

  home.packages = with pkgs; 

  [

    ################
    ### BROWSERS ###
    ################
    # firefox (added above as a program with options)
    floorp-bin # std youtube profile
    brave
    chromium
    # google-chrome (added as x86_64 only package at the bottom)
    # microsoft-edge (added as x86_64 only package at the bottom)



    ######################
    ### OFFICE-RELATED ###
    ######################
    # office programs installed via flatpak
    hunspell
    hunspellDicts.da_DK
    hunspellDicts.en_US


    # TODO: Do some sort of sorting!

    libappindicator-gtk3 # required for tray icon?


    qview # fast af image viewer
    rapidraw # gpu accel raw image editor
#    oculante # minimalistic image viewer written in rust


#    ocrmypdf # convert image only pdf to pdf+text that's searchable


		projectm-sdl-cpp # milkdrop audio visualizer


    gimp3-with-plugins
#    deskflow

#    amarok
    clementine
    asunder # cd ripper
    lame
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
  jellyfin-media-player # insecure 2025-08-30 since it uses qtwebengine 5.15.19 based on old chromium
  mesa-demos # includes everything in glxinfo
  vulkan-tools
  adwaita-icon-theme
  v4l-utils
#  guvcview

  inkscape

  gsmartcontrol
  # productivity / work

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
  

  zotero

  ]


# Packages only for x86_64 Linux
  ++ (lib.optionals (stdenv.hostPlatform.system == "x86_64-linux") [
    google-chrome
    microsoft-edge
    zoom-us
    steam-run
    upscayl
  ])

  # Packages only for aarch64 Linux
  ++ (lib.optionals (stdenv.hostPlatform.system == "aarch64-linux") [
    # arm packages here
  ]);



}
