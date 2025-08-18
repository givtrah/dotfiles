{ config, pkgs, ...}: 


let
	hostName = builtins.getEnv "HOSTNAME";
	in

{
wayland.windowManager.hyprland.settings = {
  exec-once = [
    # "hypridle & mako & waybar & fcitx5"
    # "waybar"
    # "swaybg -i ~/.config/omarchy/current/background -m fill"
    "dbus-update-activation-environment --systemd --all"
    "exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORM QT_AUTO_SCREEN_SCALE_FACTOR QT_WAYLAND_DISABLE_WINDOWDECORATION"
    "systemctl --user start hyprpolkitagent"

		"wl-clip-persist --clipboard regular & clipse -listen" # keep clipboard available even if apps close

		"nm-applet" # network-manager applet
		"blueman-applet" # bluetooth (mostly for audio purposes)

    "swaync" # notification daemon
		"swaync-client -df" # turn dnd off and print new dnd state
		"walker --gapplication-service"
		"sleep 1 && $random_wall &> /dev/null"
		"remmina -i"
		"hyprpaper"	

 	#	''ln -f -s "$HOME/.config/waybar/hypr-workspaces-$HOSTNAME.jsonc" ~/.config/waybar/hypr-workspaces.jsonc &> /dev/null''

#		"sh -c \"ln -f -s \\\"$HOME/.config/waybar/hypr-workspaces-${hostName}.jsonc\\\" $HOME/.config/waybar/hypr-workspaces.jsonc &> /dev/null\""

		 ''ln -f -s "$HOME/.config/waybar/hypr-workspaces-$HOSTNAME.jsonc" ~/.config/waybar/hypr-workspaces.jsonc &> /dev/null''
      


    ];

    exec = [
      "pkill -SIGUSR2 waybar || waybar" # reload waybar everytime hyprland reloads - this doesn't work all the time! FIX
    ];
};

  home.packages = with pkgs; 

  [


  ];


}
