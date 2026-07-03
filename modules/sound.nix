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
      
# Prevents idle suspend AND stops aggressive bluetooth microphone auto-switching
      wireplumber.extraConfig."99-disable-suspend" = {
        "wireplumber.settings" = {
          # STOP the system from automatically hijacking audio quality for the mic
          "bluetooth.autoswitch-to-headset-profile" = false;
        };

        "monitor.bluez.rules" = [
          {
            matches = [
              { "node.name" = "~bluez_input.*"; }
              { "node.name" = "~bluez_output.*"; }
            ];
            actions = {
              update-props = {
                # Keeps the speaker alive when silent
                "session.suspend-timeout-seconds" = 0; 
              };
            };
          }
        ];
      };
    };
  environment.systemPackages = builtins.attrValues { inherit (pkgs) pavucontrol alsa-utils; };
}
