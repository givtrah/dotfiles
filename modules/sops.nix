{ config, pkgs, username, ... }:

{
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/keys.txt";

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
  
  systemd.tmpfiles.rules = [
    # Allow root and system processes to traverse the sops-nix folder, but keep it clean
    "d /var/lib/sops-nix 0755 root root - -"
    
    # Make username the absolute owner of the actual key file (this requires username to be in users, which is default)
    "f /var/lib/sops-nix/keys.txt 0600 ${username} users - -"
    
    # Create the home configuration directory structure for your user
    "d /home/${username}/.config/sops/age 0700 ${username} users - -"
    
    # 4. Create the declarative symlink pointing back to your user-owned /var/lib file
    "L+ /home/${username}/.config/sops/age/keys.txt - - - - /var/lib/sops-nix/keys.txt"
  ];


  environment.systemPackages = with pkgs; [ sops ];
}
