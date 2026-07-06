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

  programs.mpv.enable = true;

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

    zathura # pdf viewer
    inkscape
    zotero # reference manager

    #####################
    ### IMAGE RELATED ###
    #####################
    qview # fast af image viewer
    rapidraw # gpu accel raw image editor
    oculante # fast, minimalistic image viewer written in rust
    kdePackages.gwenview
    imv # simple image viewer
    gimp3-with-plugins
    grim

    #####################
    ### SOUND RELATED ###
    #####################
    clementine
    fooyin # foobar2k alternative
    asunder # cd ripper
    kid3 # mp3 tagger
		projectm-sdl-cpp # milkdrop audio visualizer
    # amarok # mp3 player - currently broken?

    #####################
    ### VIDEO RELATED ###
    #####################
    vlc
    mkvtoolnix
    guvcview
    jellyfin-media-player 
    
    #########################
    ### MESSAGING RELATED ###
    #########################
    telegram-desktop
    signal-desktop

    ########################
    ### HARDWARE RELATED ###
    ########################
    lact # GPU configuration
    piper # gaming mouse configuration (needs ratbagd)
    mesa-demos # includes everything in glxinfo
    vulkan-tools
    gsmartcontrol

    ############
    ### MISC ###
    ############
    calibre # ebook management
    gnome-multi-writer
    qbittorrent
    kdePackages.kcalc # ensures kcalc is installed
    obsidian # Note taking app (non-free)
    remmina # remote desktop client

    # ocrmypdf # convert image only pdf to pdf+text that's searchable
    # deskflow # share mouse/keyboard with nearby computers - unused atm

  ]


# Packages only for x86_64 Linux
  ++ (lib.optionals (stdenv.hostPlatform.system == "x86_64-linux") [
    google-chrome
    makemkv
    microsoft-edge
    steam-run
    upscayl
    zoom-us
  ])

  # Packages only for aarch64 Linux
  ++ (lib.optionals (stdenv.hostPlatform.system == "aarch64-linux") [
    # arm packages here
  ]);



}
