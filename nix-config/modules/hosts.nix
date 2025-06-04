{ pkgs, lib, options, ... }:

{

# Tailscale hosts
  networking.hosts = {
    "100.97.227.101" = [ "tauml" ];

  };
}

