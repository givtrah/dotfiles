{ config, pkgs, ...}: {

# DO THESE NEED TO BE GLOBAL?!?!?


  # Hint electron apps to use Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
  # Disable hardware cursors
  home.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

##################
# ENV VARIABLES ##
##################
# some from https://bbs.archlinux.org/viewtopic.php?id=285373
# some from hyprland wiki

# Scale GTK apps
env = GDK_SCALE,2

# GTK: Use wayland if available. If not: try x11, then any other GDK backend.
env = GDK_BACKEND,wayland,x11,*

# Qt: Use wayland if available, fall back to x11 if not.
env = QT_QPA_PLATFORM,wayland;xcb

# use QT5 theme for KDE apps (QT6 apps should use qt6ct automatically)
env = QT_QPA_PLATFORMTHEME,qt5ct

# Run SDL2 applications on Wayland. Set to x11 if old games cause compatibility issues
# env = SDL_VIDEODRIVER,wayland

# Force Clutter applications to try and use the Wayland backend
env = CLUTTER_BACKEND,wayland

# Fix Java apps rendering on Wayland
env = _JAVA_AWT_WM_NONREPARENTING,1

# Fix QT apps on hi-DPI displays (so they don't appear tiny)
env = QT_AUTO_SCREEN_SCALE_FACTOR,1

# QT apps should use the Wayland backend
env = QT_QPA_PLATFORM,wayland

# QT apps should not draw their own window decorations
env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

# Mozilla apps should use Wayland
env = MOZ_ENABLE_WAYLAND,1

# Mozilla apps use the GPU accelerated 2D rendering engine
env = MOZ_WEBRENDER,1

# Enable apps use hardware acceleration
env = MOZ_ACCELERATED,1

# Make KDE/Dolphin menus work outside of KDE
env = XDG_MENU_PREFIX,plasma-

# Cursor size
env = XCURSOR_SIZE,32
env = HYPRCURSOR_SIZE,32

# unscale XWayland
xwayland {
  force_zero_scaling = true
}


#


# See https://wiki.hyprland.org/Configuring/Environment-variables/

env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24



  home.packages = with pkgs; 

  [


  ];


}
