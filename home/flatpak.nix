{ lib, config, pkgs, ... }:
{

 # nix-flatpak setup
  services.flatpak.enable = true;
  services.flatpak.update.auto.enable = true;
  services.flatpak.uninstallUnmanaged = true;

  services.flatpak.packages = [
#    "com.github.IsmaelMartinez.teams_for_linux"
    "com.github.tchx84.Flatseal"
		"org.onlyoffice.desktopeditors" # Onlyoffice (should work on both x86_64 and aarch64 platforms)
		"org.libreoffice.LibreOffice" # should work on both x86_64 and aarch64
#		"com.valvesoftware.Steam"
    "com.heroicgameslauncher.hgl"
    "org.freedesktop.Platform.VulkanLayer.MangoHud"
  ];



}
