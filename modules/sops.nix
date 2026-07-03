{ config, pkgs, username, ... }:

{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/keys.txt"; 

    # 1. Register the secrets first so the placeholders exist!
    secrets = {
      test = { owner = username; };
      hosts = { mode = "0444"; }; 
      work_timeserver = { mode = "0444"; };
    };

  };

  environment.systemPackages = with pkgs; [ sops ];
}
