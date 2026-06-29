{ inputs, lib, config, pkgs, username, hostName, ... }: { 

  # =========================================================================
  # USER CONFIGURATION (Home Manager Space)
  # =========================================================================
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    systemd.enable = false;

    extraConfig = ''
      local home = os.getenv("HOME")
      package.path = package.path .. ";" .. home .. "/.config/hypr/?.lua"

      require("monitors")
      require("core")
      require("looknfeel")
      require("windows")
      require("keybindings")
      require("autostart")
    '';
  };
    
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gnome
      ];
      config = { 
        common = {
          default = [ "hyprland" ];
          };
        };
    };

    configFile = {
       # ENVIRONMENT
      "uwsm/env".text = builtins.readFile ./uwsm-env;

      # HYPRLAND CONFIG
      "hypr/core.lua".text        = builtins.readFile ./core.lua;
      "hypr/keybindings.lua".text = builtins.readFile ./keybindings.lua;
      "hypr/autostart.lua".text   = builtins.readFile ./autostart.lua;
      "hypr/looknfeel.lua".text   = builtins.readFile ./looknfeel.lua;
      "hypr/windows.lua".text     = builtins.readFile ./windows.lua;

      # Per-host monitor file routing using native path coercion
      "hypr/monitors.lua".text = 
        let
          # Convert the string name dynamically into a true Nix path object
          expectedPath = ./. + "/monitors-${hostName}.lua";
        in
          if builtins.pathExists expectedPath 
          then builtins.readFile expectedPath
          else builtins.readFile ./monitors-default.lua;
    };
  };


  dconf.settings = { 
    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    gtk4.theme = config.gtk.theme; # home-manager update
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct"; # Tells Qt apps to look at qt5ct/qt6ct configurations
    style = {
      name = "breeze-dark";      # Uses the breeze-dark style engine
      package = pkgs.kdePackages.breeze;
    };
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    hyprcursor.enable = true; # Enables native Hyprland cursor support
    package = pkgs.catppuccin-cursors.mochaSapphire;
    name = "catppuccin-mocha-sapphire-cursors";
    size = 24; # Highly recommended for standard scaling; 48 can be massive on non-4K screens
  };

    # Import configured helper programs
  imports = [
    ./hypridle.nix
    ./hyprlock.nix
    # ./hyprpaper.nix # Buggy, using swaybg atm
    ../waybar
    ../rofi.nix
  ];

  home.packages = with pkgs; [
    # Should only contain programs necessary for the function of Hyprland, NOT normal called programs
    
    # Import helper scripts
    (import ./scripts/wall-random.nix { inherit pkgs; wallpaperDir = ../../wallpapers; })
    (import ./scripts/waybar-reload.nix { inherit pkgs; })

    # Autostart programs (so yes, needed!), some are imported below!
    maestral # Dropbox 
    maestral-gui
    bluez-tools # bluez e.g. bluetooth enabled is handled by main config with hardware.bluetoothe.enable = true 
    bluez-experimental
    wl-clipboard
    upower # unsure if this is needed
    networkmanagerapplet
    swaynotificationcenter # notification daemon
    cava # console based audio visualizer (plugin for waybar)
    wl-gammactl # wayland contrast, brightness and gamma adjustments
		brightnessctl # brightness control

    ######################
    # HYPRLAND ECOSYSTEM #
    ######################
    hyprdim # Automatically dim windows when switching between them
    hyprshot # Hyprland screen shot utility
    hyprsunset # Application to enable a blue-light filter on Hyprland
    hyprsysteminfo # A tiny qt6/qml application to display information about the running system
    hyprland-qtutils # Hyprland QT/qml utility apps
    hyprland-protocols # Wayland protocol extensions for Hyprland
    hyprland-qt-support # A Qt6 QML provider for hypr* apps
    hyprland-activewindow # Multi-monitor-aware Hyprland workspace widget helper
    hyprpicker # Wlroots-compatible Wayland color picker that does not suck
    hyprcursor # Hyprland cursor format, library and utilities

    # Toolkit Integration Frameworks
    qt5.qtwayland
    kdePackages.plasma-workspace # Ensure plasma-applications.menu appears (to help mime associations in dolphin)
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum
    adwaita-icon-theme # for dconf enable above, fix gnome window decorations
    # may be superfluous
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons


    ];

}
