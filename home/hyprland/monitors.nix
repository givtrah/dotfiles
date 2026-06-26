{ config, pkgs, hostName,...}: 

##############################
### MONITORS  & Workspaces ###
##############################

# See https://wiki.hyprland.org/Configuring/Monitors/
# monitor=,preferred,auto,auto

let hostname = hostName;

  monitorConfigs = {
    taude = [
      "DP-1, 3840x2160, 0x0, 1.5"
      "DP-2, 3840x2160, 2560x0, 1.5"
    ];
    taupa = [
      "DP-2, 3840x2160, 0x0, 1.5"
      "DP-4, 3840x2160, 2560x-560, 1.5, transform, 1"
			"DP-4, addreserved, 350, 0, 0, 0, 0"
    ];
    taumac = [
      ",preferred,auto,auto"
    ];
    tausurf = [
      ",preferred,auto,auto"
    ];
    default = [
      ",preferred,auto,auto"
    ];
  };


 workspaceConfigs = {
    taude = [
      "1,persistent,monitor:DP-1"
      "2,persistent,monitor:DP-1"
      "3,persistent,monitor:DP-1"
      "4,persistent,monitor:DP-1"
      "5,persistent,monitor:DP-1"
      "6,persistent,monitor:DP-1"
      "7,persistent,monitor:DP-1"
      "8,persistent,monitor:DP-2"
      "9,persistent,monitor:DP-2"
      "10,persistent,monitor:DP-2"
      "1,default:true,monitor:DP-1"
      "8,default:true,monitor:DP-2"
    ];
    taupa = [
      "1,persistent,monitor:DP-2"
      "2,persistent,monitor:DP-2"
      "3,persistent,monitor:DP-2"
      "4,persistent,monitor:DP-2"
      "5,persistent,monitor:DP-2"
      "6,persistent,monitor:DP-2"
      "7,persistent,monitor:DP-2"
      "8,persistent,monitor:DP-4"
      "9,persistent,monitor:DP-4"
      "10,persistent,monitor:DP-4"
      "1,default:true,monitor:DP-2"
      "8,default:true,monitor:DP-4"
    ];
    taumac = [
      "1,persistent,monitor:eDP-1"
      "2,persistent,monitor:eDP-1"
      "3,persistent,monitor:eDP-1"
      "4,persistent,monitor:eDP-1"
      "5,persistent,monitor:eDP-1"
      "6,persistent,monitor:eDP-1"
      "7,persistent,monitor:eDP-1"
      "8,persistent,monitor:DP-2" # unsure what additional displaylink monitor will be called, TEST!
      "9,persistent,monitor:DP-2"
      "10,persistent,monitor:DP-2"
      "1,default:true,monitor:eDP-1"
      "8,default:true,monitor:DP-2"
    ];

    tausurf = [
      "1,persistent,monitor:eDP-1"
      "2,persistent,monitor:eDP-1"
      "3,persistent,monitor:eDP-1"
      "4,persistent,monitor:eDP-1"
      "5,persistent,monitor:eDP-1"
      "6,persistent,monitor:eDP-1"
      "7,persistent,monitor:eDP-1"
      "8,persistent,monitor:DP-2" # unsure what additional displaylink monitor will be called, TEST!
      "9,persistent,monitor:DP-2"
      "10,persistent,monitor:DP-2"
      "1,default:true,monitor:eDP-1"
      "8,default:true,monitor:DP-2"
    ];







    default = [ ];
  };

in

{
  wayland.windowManager.hyprland.settings = {
    monitor = monitorConfigs.${hostname} or monitorConfigs.default;
    workspace = workspaceConfigs.${hostname} or workspaceConfigs.default;
  };

}

