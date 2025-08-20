{ config, pkgs, inputs, lib, ... }: {
  imports = [
    #    inputs.nixos-cosmic.nixosModules.default
  ];
   
  config = {
    services.desktopManager.cosmic.enable = true;
    #    services.displayManager.cosmic-greeter.enable = true;
  };
}
