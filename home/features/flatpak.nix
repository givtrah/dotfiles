{ lib, config, pkgs, ... }:
{

 # nix-flatpak setup
  services.flatpak.enable = true;

#  services.flatpak.remotes = lib.mkOptionDefault [{
#    name = "flathub-beta";
#    location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
#  }];

  services.flatpak.update.auto.enable = false;
  services.flatpak.uninstallUnmanaged = false;

  services.flatpak.packages = [
    #{ appId = "com.brave.Browser"; origin = "flathub"; }
#    "com.usebottles.bottles"
#    "org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08" # CAREFUL, VERSION MIGHT BE INCOMPATIBLE WITH BOTTLES IN THE FUTURE!
#    "org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08"
    "com.github.IsmaelMartinez.teams_for_linux"
    "com.github.tchx84.Flatseal"
		"org.onlyoffice.desktopeditors" # Onlyoffice (should work on both x86_64 and aarch64 platforms)
		"com.collaboraoffice.Office" # Collabora office (currently plugins not working, should work on x86_64 and aarch64 platforms)
		"org.libreoffice.LibreOffice" # should work on both x86_64 and aarch64

		"com.valvesoftware.Steam"


#    "xyz.armcord.ArmCord"
    

  ];



}
