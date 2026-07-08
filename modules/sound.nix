{ pkgs, ... }:
{
  services.pulseaudio.enable = false; 
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    
    # WirePlumber 0.5+ syntax for settings and monitor rules
    wireplumber.extraConfig = {
      "10-bluetooth-settings" = {
        "wireplumber.settings" = {
          # allows auto-switching when an application requests input
          "bluetooth.autoswitch-to-headset-profile" = true;
        };
      };

      "99-disable-suspend" = {
        "monitor.bluez.rules" = [
          {
            matches = [
              { "node.name" = "~bluez_output.*"; }
            ];
            actions = {
              update-props = {
                "session.suspend-timeout-seconds" = 0; # Keeps the streams alive
              };
            };
          }
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    alsa-utils
  ];
}
