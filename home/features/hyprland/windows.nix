{ config, pkgs, ...}: {


 wayland.windowManager.hyprland.settings = {
    windowrule = [
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

#			"suppress_event maximize, match:class .*"   # prevents full screen windows too?

      # Force chromium into a tile to deal with --app bug
  #    "tile, class:^(chromium)$"

      # Settings management
 #     "float, class:^(org.pulseaudio.pavucontrol|blueberry.py)$"

      # Float Steam, fullscreen RetroArch
#      "float, class:^(steam)$"
#      "fullscreen, class:^(com.libretro.RetroArch)$"

			"float on, match:class ^(Zotero)$, match:title .*Preferences*"
			"float on, match:class ^(Zotero)$, match:title .*Citation*"



      # Just dash of transparency
#      "opacity 0.97 0.9, class:.*"
      # Normal chrome Youtube tabs
#      "opacity 1 1, class:^(chromium|google-chrome|google-chrome-unstable)$, title:.*Youtube.*"
#      "opacity 1 0.97, class:^(chromium|google-chrome|google-chrome-unstable)$"
#      "opacity 0.97 0.9, initialClass:^(chrome-.*-Default)$ # web apps"
#      "opacity 1 1, initialClass:^(chrome-youtube.*-Default)$ # Youtube"
#      "opacity 1 1, class:^(zoom|vlc|org.kde.kdenlive|com.obsproject.Studio)$"
#      "opacity 1 1, class:^(com.libretro.RetroArch|steam)$"

      # Fix some dragging issues with XWayland
      "no_focus on,match:class ^$,match:xwayland 1,match:float 1,match:fullscreen 0,match:pin 0"

			# fix kcalc (this or the one below? eh?)
			"float on, match:class ^(org.kde.kcalc)$"
			"size 400 400, match:class ^(org.kde.kcalc)$"
			"focus_on_activate on, match:class ^(org.kde.kcalc)$"
			"move onscreen cursor -200 -200, match:class ^(org.kde.kcalc)$"

      # Float in the middle for clipse clipboard manager
#      "float, class:(clipse)"
#      "size 622 652, class:(clipse)"
#      "stayfocused, class:(clipse)"

			 # fix mpv no video only audio
			"content none, match:class ^(mpv)$"

			# hide and fix xwaylandvideobridge
			"opacity 0.0 override, match:class ^(xwaylandvideobridge)$"
			"no_anim on, match:class ^(xwaylandvideobridge)$"
			"no_initial_focus on, match:class ^(xwaylandvideobridge)$"
			"max_size 1 1, match:class ^(xwaylandvideobridge)$"
			"no_blur on, match:class ^(xwaylandvideobridge)$"
			"no_focus on, match:class ^(xwaylandvideobridge)$"





# STUFF I MIGHT NEED LATER

# Firefox: class: firefox - title contains: "Mozilla Firefox". initialTitle: Mozilla Firefox

# Floorp: class: floorp. title contains: "Ablaze Floorp" initialTitle: "Ablaze Floorp"

# Jellyfin: class: class: com.github.iwalton3.jellyfin-media-player
#	title: Jellyfin Media Player


# class: com.github.iwalton3.jellyfin-media-player
#	title: Jellyfin Media Player
#initialClass: com.github.iwalton3.jellyfin-media-player
#	initialTitle: Jellyfin Media Player


#   class: com.usebottles.bottles
#	title: Bottles
#	initialClass: com.usebottles.bottles
#	initialTitle: Bottles


    ];

# deprecated 2026-02-07
#		windowrulev2 = [
#			# Unsure if this is needed?
#			"float, size 300 200, class:^(org.kde.kcalc)$, title:^(KCalc)$"
#		];



    layerrule = [
      # Proper background blur for walker and waybar
      "blur on,match:namespace walker"
      "blur on,match:namespace waybar"
    ];
  };








  home.packages = with pkgs; 

  [


  ];


}
