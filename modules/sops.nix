{ config, pkgs, username, ... }:{
  
  # Ensure permissions on keys.txt are fine
  systemd.tmpfiles.rules = [
    # Allow root and system processes to traverse the sops-nix folder
    "d /var/lib/sops-nix 0755 root root - -"
    
    # Make username the sole owner of keys.txt file (this requires username to be in users, which is default)
    "f /var/lib/sops-nix/keys.txt 0600 ${username} root - -"
  ];

  # point userspace to the key file (secured by above), needs a restart to work
  environment.sessionVariables = {
    SOPS_AGE_KEY_FILE = "/var/lib/sops-nix/keys.txt";
  };

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
  # Add TS hosts to /etc/hosts 
  # Force NixOS to write a real, mutable file /etc/hosts instead of a read-only symlink
  environment.etc.hosts.mode = "0644";

  # Append private SOPS TS hosts directly into the file at switch-time!
  system.activationScripts.appendSopsHosts = { 
    deps = [ "etc" ]; # wait for /etc to be populated
    text = ''
      if [ -f "${config.sops.secrets.hosts.path}" ]; then
        # Wipe any old block to keep the file clean on repeat switches
        ${pkgs.gnused}/bin/sed -i '/# SOPS START/,/# SOPS END/d' /etc/hosts

        # Append the secret path contents directly
        echo "# SOPS START" >> /etc/hosts
        ${pkgs.coreutils}/bin/cat "${config.sops.secrets.hosts.path}" >> /etc/hosts
        echo "# SOPS END" >> /etc/hosts
      fi
    '';
  };
  
  environment.systemPackages = with pkgs; [ sops ];
}
