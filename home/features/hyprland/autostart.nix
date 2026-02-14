{ config, pkgs, ...}: 


let
	hostName = builtins.getEnv "HOSTNAME";
	in

{
wayland.windowManager.hyprland.settings = {
  exec-once = [
    # mako & fcitx5"
    "dbus-update-activation-environment --systemd --all"
    "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP QT_QPA_PLATFORM QT_AUTO_SCREEN_SCALE_FACTOR QT_WAYLAND_DISABLE_WINDOWDECORATION"
    "systemctl --user start hyprpolkitagent"
# https://discourse.nixos.org/t/hyprland-with-uwsm-no-secret-service-available-on-login-kwallet-is-installed-but-it-wont-start-and-autounlock/69263
    "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init"
#

#		"kwallet-query -l kdewallet &> /dev/null" # force opening of kdewallet
		"wl-clip-persist --clipboard regular & clipse -listen" # keep clipboard available even if apps close

		"nm-applet" # network-manager applet
		"blueman-applet" # bluetooth (mostly for audio purposes)

    "swaync" # notification daemon
		"swaync-client -df" # turn dnd off and print new dnd state
#		"walker --gapplication-service" # is done in walker.nix now
		"sleep 1 && $random_wall &> /dev/null"
		"remmina -i"
		"hyprpaper"	


#		 ''ln -f -s "$HOME/.config/waybar/hypr-workspaces-$HOSTNAME.jsonc" ~/.config/waybar/hypr-workspaces.jsonc &> /dev/null''
# no longer needed     


    ];

    exec = [
      "pkill -SIGUSR2 waybar || waybar" # reload waybar everytime hyprland reloads - this doesn't work all the time! FIX
    ];
};

  home.packages = with pkgs; 

  [


  ];


}
