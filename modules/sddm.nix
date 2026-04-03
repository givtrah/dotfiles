{ pkgs, ... }:
{

	# Find the name of themes for sddm:

	# ls /run/current-system/sw/share/sddm/themes

  services.xserver.enable = true;
  
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
#    theme = "astronaut"; # The only theme working?!?!?
  };

# set default session to Hyprland
	services.displayManager.defaultSession = "hyprland-uwsm";


# Auto login to kwallet upon login using sddm
# security.pam.services.sddm = {
#  kwallet = {
#    enable = true;
#    package = pkgs.kdePackages.kwallet-pam;
#  };
# };
# Enable kwallet (might be needed?)
# security.pam.services.kwallet = {
#  name = "kwallet";
#  enableKwallet = true;
# };

  security = {
    # If enabled, pam_wallet will attempt to automatically unlock the user’s default KDE wallet upon login.
    # If the user has no wallet named “kdewallet”, or the login password does not match their wallet password,
    # KDE will prompt separately after login.
    pam = {
      services = {
        ohm = {
          kwallet = {
            enable = true;
            package = pkgs.kdePackages.kwallet-pam;
          };
        };
      };
    };
};





environment.systemPackages = with pkgs; [
  sddm-chili-theme
	elegant-sddm
	sddm-sugar-dark
	sddm-astronaut
#	catppuccin-sddm.override {
#    flavor = "mocha";
#    font  = "Noto Sans";
#    fontSize = "9";
#    background = "${./wallpaper.png}";
#    loginBackground = true;
#	  } 
];


  # Modify the SDDM theme to chili by getting it directly from github (todo: use the sddm-chili-theme which is a nix pkg)
#  services.displayManager.sddm.theme = "${(pkgs.fetchFromGitHub {
#      owner = "MarianArlt";
#      repo = "kde-plasma-chili";
#      rev = "a371123959676f608f01421398f7400a2f01ae06";
#      sha256 = "17pkxpk4lfgm14yfwg6rw6zrkdpxilzv90s48s2hsicgl3vmyr3x";
#  })}";


}
