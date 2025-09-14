{ inputs, lib, config, pkgs, ... }:
{

 	wayland.windowManager.hyprland = {
   	enable = true;
 #  	package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  	};
  
	services.hyprpolkitagent.enable = true; # Polkit auth agent written in QT/QML


	# Make screen sharing work? (from wiki.nixos.org 2025-08-27)
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
	};


	imports = [
		./hyprland/configuration.nix
		./hypridle.nix # needs swaylock (hyprlock currently broken on aarch64 apple silicon)
		./swaylock.nix
		./hyprpaper.nix # essentially empty config, but it crashes without ANY config.. sigh
		./waybar.nix
		./pywal16.nix
		./walker.nix
	];






# Hyprland related packages
  home.packages = with pkgs; [
    hyprdim # Automatically dim windows when switching between them
    hyprsome # Awesome WM like workspaces for Hyprland (per monitor workspaces)
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

#    pywal16
    hellwal
    wallust

    swaynotificationcenter # notification daemon
	libsForQt5.qt5.qtwayland
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
#    walker # menu
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
		bitwarden-desktop
		signal-desktop

    waypaper

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
    nerd-fonts.hack

    #    libsForQt5.breeze-qt5
    # libsForQt5.breeze-gtk
    # libsForQt5.breeze-icons

    


  ];


}
