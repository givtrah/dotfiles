{ config, pkgs, ...}: {

# DO THESE NEED TO BE GLOBAL?!?!?


  # Hint electron apps to use Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  # Disable hardware cursors
  home.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

	wayland.windowManager.hyprland.settings = {
		
		env = [
		##################
		# ENV VARIABLES ##
		##################
		# some from https://bbs.archlinux.org/viewtopic.php?id=285373
		# some from hyprland wiki
		# See https://wiki.hyprland.org/Configuring/Environment-variables/

		# Scale GTK apps
		"GDK_SCALE,2"

		# Cursor size (32 or 24?)
		"XCURSOR_SIZE,24"
		"HYPRCURSOR_SIZE,24"

		# Cursor theme
		"XCURSOR_THEME,Adwaita" # Do I need to install these?
		"HYPRCURSOR_THEME,Adwaita"

		# Force (all?) apps to use Wayland and misc other fixes below

		# GTK: Use wayland if available. If not: try x11, then any other GDK backend.
		"GDK_BACKEND,wayland,x11,*"

		# Qt: Use wayland if available, fall back to x11 if not.
		"QT_QPA_PLATFORM,wayland;xcb"
		# #QT_QPA_PLATFORM,wayland"

		# use QT5 theme for KDE apps (QT6 apps should use qt6ct automatically)
		"QT_QPA_PLATFORMTHEME,qt5ct"

		# ???? - seems to completely mess up dolphin
#		"QT_STYLE_OVERRIDE,kvantum"

		# Run SDL2 applications on Wayland. Set to x11 if old games cause compatibility issues
#		"SDL_VIDEODRIVER,wayland"

		# Force Clutter applications to try and use the Wayland backend
		"CLUTTER_BACKEND,wayland"
		
		# Mozilla apps should use Wayland
		"MOZ_ENABLE_WAYLAND,1"

		# Make Chromium use XCompose and all Wayland
    "CHROMIUM_FLAGS,\"--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4\""

		# Electron apps
		"ELECTRON_OZONE_PLATFORM_HINT,wayland"	

		# ???
		"OZONE_PLATFORM,wayland"

		# Fix Java apps rendering on Wayland
		"_JAVA_AWT_WM_NONREPARENTING,1"

		# Fix QT apps on hi-DPI displays (so they don't appear tiny)
		"QT_AUTO_SCREEN_SCALE_FACTOR,1"

		# QT apps should not draw their own window decorations
		"QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

		# Mozilla apps use the GPU accelerated 2D rendering engine
		"MOZ_WEBRENDER,1"

		# Enable apps use hardware acceleration
		"MOZ_ACCELERATED,1"

		# Make KDE/Dolphin menus work outside of KDE
		"XDG_MENU_PREFIX,plasma-"

		# Not needed? (using walker)
    "XDG_DATA_DIRS,$XDG_DATA_DIRS:$HOME/.nix-profile/share:/nix/var/nix/profiles/default/share"

		# GTK theme
    "GTK_THEME,Adwaita:dark"


		];


		# unscale XWayland
		xwayland = {
  		force_zero_scaling = true;
		};

	};


  home.packages = with pkgs; 

  [


  ];


}
