{ config, pkgs, username, ... }:

{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

    # Register secrets first so the placeholders exist!
    secrets = {
      hosts = { mode = "0444"; }; 
      work_timeserver = { mode = "0444"; };

      # We declare these here so sops generates the decryption metadata hooks
      ssh_config = {};
      ssh_external_key = {};
      ssh_external_pub = {};
    };

    # Extract raw content out to target destination files
    templates = {
      "ssh_config" = {
        path = "/home/${username}/.ssh/config";
        owner = username;
        mode = "0600";
        content = config.sops.placeholder.ssh_config;
      };
      "ssh_external_key" = {
        path = "/home/${username}/.ssh/external_key";
        owner = username;
        mode = "0600";
        content = config.sops.placeholder.ssh_external_key;
      };
      "ssh_external_pub" = {
        path = "/home/${username}/.ssh/external_key.pub";
        owner = username;
        mode = "0644";
        content = config.sops.placeholder.ssh_external_pub;
      };
    };
  };

# Declaratively enforce strict, minimal single-user permissions
  systemd.tmpfiles.rules = [
    # 1. Ensure the parent directory is root-owned and secure
    "d /var/lib/sops-nix 0755 root root - -"
    
    # 2. Force the key file to be owned directly by your user (ohm)
    # 0600 means Read/Write for you, and absolutely NO access for anyone else
    "f /var/lib/sops-nix/keys.txt 0600 ${username} users - -"
  ];


  environment.systemPackages = with pkgs; [ sops ];
}
