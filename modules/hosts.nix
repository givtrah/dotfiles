{ pkgs, lib, options, ... }:

{

# Tailscale hosts I frequently access
  networking.hosts = {
    "100.116.102.99" = [ "tauml" ];
		"100.118.35.5" = [ "taupa" ];
		"100.76.98.37" = [ "taude" ];
  };
}

