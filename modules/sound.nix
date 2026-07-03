{ pkgs, ... }:
{
  # disable default sound module. see https://nixos.wiki/wiki/PipeWire
#  sound.enable = false; # sound.enable only meant for alsa sound
  services.pulseaudio.enable = false; 

  security.rtkit.enable = true;

  services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      
      # Prevents Bluetooth audio nodes from suspending when idle
      wireplumber.extraConfig."99-disable-suspend" = {
        "monitor.bluez.rules" = [
          {
            matches = [
              { "node.name" = "~bluez_input.*"; }
              { "node.name" = "~bluez_output.*"; }
            ];
            actions = {
              update-props = {
                "session.suspend-timeout-seconds" = 0; # 0 disables suspend completely
              };
            };
          }
        ];
      };
    };

  environment.systemPackages = builtins.attrValues { inherit (pkgs) pavucontrol alsa-utils; };
}
