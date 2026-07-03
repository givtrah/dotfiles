{ pkgs, username, ... }:{
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

# set default session to Hyprland
	services.displayManager.defaultSession = "hyprland-uwsm";

  security = {
    # If enabled, pam_wallet will attempt to automatically unlock the user’s default KDE wallet upon login.
    # If the user has no wallet named “kdewallet”, or the login password does not match their wallet password,
    # KDE will prompt separately after login.
    pam = {
      services = {
        ${username} = {
          kwallet = {
            enable = true;
            package = pkgs.kdePackages.kwallet-pam;
          };
        };
      };
    };
  };

environment.systemPackages = with pkgs; [

];




}
