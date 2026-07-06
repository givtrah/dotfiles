{ config, pkgs, lib, inputs, username, hostName, ...}: {

# In your system packages:
  home.packages = with inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}; [
    opencode
    pi
    
    hermes-agent
    hermes-desktop
    hermes-hud

    handy
    voxtype
    # ... other tools
  ];



}
