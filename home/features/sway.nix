{ inputs, lib, config, pkgs, ... }:
{

# https://github.com/rx342/partio 

# Might need kanshi, might need swayws
# swaylock-fancy
# swaylock-effects
# sov
# autotiling-rs

# consider nwg-panel
# swaybg

  wayland.windowManager.sway = {
		enable = true;
		wrapperFeature.gtk = true;
		package = pkgs.sway; # change to swayfx once config is up and running!
		};

	services.hyprpolkitagent.enable = true; # Polkit auth agent written in QT/QML

	# Make screen sharing work? 
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
	};


	imports = [
		./sway/configuration.nix
		./hypridle.nix # 
		./swaylock.nix
		./hyprpaper.nix # essentially empty config, but it crashes without ANY config.. sigh
		./waybar.nix
		./pywal16.nix
		./wofi.nix
	];






# Hyprland related packages
  home.packages = with pkgs; [

		swayidle


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
#    nerd-fonts.hack

    #    libsForQt5.breeze-qt5
    # libsForQt5.breeze-gtk
    # libsForQt5.breeze-icons

    


  ];


}
