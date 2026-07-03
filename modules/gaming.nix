{ config, pkgs, ...}: {

  # Steam
  programs.steam = {
    enable = true; 
    extest.enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
    package = pkgs.steam.override {
      extraArgs = "-system-composer";    
    };
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extraPackages = with pkgs; [
      steamcmd 
      protonup-qt
    ];
  };
  
  # Ensure gamemode is enabled
  programs.gamemode.enable = true;

}
