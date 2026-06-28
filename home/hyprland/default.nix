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

    xdg.configFile = {
      "hypr/core.lua".text        = builtins.readFile ./core.lua;
      "hypr/keybindings.lua".text = builtins.readFile ./keybindings.lua;
      "hypr/autostart.lua".text   = builtins.readFile ./autostart.lua;
      "hypr/looknfeel.lua".text   = builtins.readFile ./looknfeel.lua;
      "hypr/windows.lua".text     = builtins.readFile ./windows.lua;

      # FIXED: Per-host monitor file routing using native path coercion
      "hypr/monitors.lua".text = 
        let
          # Convert the string name dynamically into a true Nix path object
          expectedPath = ./. + "/monitors-${hostName}.lua";
        in
          if builtins.pathExists expectedPath 
          then builtins.readFile expectedPath
          else ''
            -- ==========================================
            -- FALLBACK DEFAULT MONITOR CONFIGURATION
            -- ==========================================
            hl.monitor({ name = "", resolution = "preferred", position = "auto", scale = "auto" })

            for i = 1, 5 do
              hl.workspace_rule({ workspace = tostring(i), persistent = true })
            end
          '';

      "uwsm/env".text = builtins.readFile ./uwsm-env;

    };

    home.packages = with pkgs; [
      (import ./scripts/wall-random.nix { inherit pkgs; wallpaperDir = ../../wallpapers; })
      (import ./scripts/waybar-reload.nix { inherit pkgs; })

		xdg-utils # XDG utility, not sure if it should stay here

	  grim #  needed for flameshot on wayland

    hyprdim # Automatically dim windows when switching between them
    hyprshot # Hyprland screen shot utility

    # hyprprop # An xprop replacement for Hyprland - no idea what this does

    hyprlock # Screen lock utility

    hyprsunset # Application to enable a blue-light filter on Hyprland

    hyprsysteminfo # A tiny qt6/qml application to display information about the running system

    hyprland-qtutils # Hyprland QT/qml utility apps
    hyprland-protocols # Wayland protocol extensions for Hyprland
    hyprland-qt-support # A Qt6 QML provider for hypr* apps
    hyprland-activewindow # Multi-monitor-aware Hyprland workspace widget helper

#    hyprlandPlugins.hyprsplit # AwesomeWM / DWM / Krohnkite like workspaces (From 1 per monitor)
#    hyprlandPlugins.hyprtrails # Trails after moving windows


    pyprland
    hyprpicker # Wlroots-compatible Wayland color picker that does not suck
    hyprcursor # Hyprland cursor format, library and utilities
    hyprpaper # Blazing fast wayland wallpaper utility

    pywal16

    swaynotificationcenter # notification daemon
	qt5.qtwayland
#	qtwayland # cross-platform framework needed for QT support on Wayland
    
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gnome

#    waybar # activated inside waybar.nix
    cava # console based audio visualizer (plugin for waybar)

    zathura
    mpv
    imv
    
    # extra...
    wofi # menu
    yazi # file-manager

    #    bluez
    bluez-tools
    bluez-experimental
    blueman
    # bluetui
    wl-clipboard
    upower

    networkmanagerapplet

    pulsemixer # cli volume control

    #    hyprpanel


		amarok
#		bitwarden-desktop
		signal-desktop

    wl-gammactl # wayland contrast, brightness and gamma adjustments

		brightnessctl # brightness control

    # Ensure plasma-applications.menu appears (to help mime associations in dolphin)
    kdePackages.plasma-workspace

    # QT theming
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qt6ct
    kdePackages.qtstyleplugin-kvantum

    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons

    # standard font for KDE? (I think)
#    nerd-fonts.hack

    #    libsForQt5.breeze-qt5
    # libsForQt5.breeze-gtk
    # libsForQt5.breeze-icons

    ];

    imports = [
      ./hypridle.nix
      ./hyprlock.nix
      ../waybar
#      ../pywal16.nix
      ../rofi.nix
    ];
}
