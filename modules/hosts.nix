{ pkgs, lib, options, ... }:

{

  networking.extraHosts = ''
    if [ -f "${config.sops.secrets.work_hosts.path}" ]; then
      cat "${config.sops.secrets.work_hosts.path}"
    fi
  '';


# Tailscale hosts I frequently access
#  networking.hosts = {
#    "100.116.102.99" = [ "tauml" ];
#		"100.118.35.5" = [ "taupa" ];
#		"100.76.98.37" = [ "taude" ];
#  };
}

