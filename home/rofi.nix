{ lib, config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    
    extraConfig = {
      modi = "drun,run,window";
      icon-theme = "Papirus";
      show-icons = true;
      terminal = "alacritty"; # Change to your preferred term
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      sidebar-mode = true;
    };

    # Rofi 2.0+ uses RASI themes. We can write this as a multi-line string.
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
        "@import" = lib.mkForce "~/.cache/wal/colors-rofi-dark.rasi";

      "*" = {
        # Importing Pywal colors - Rofi doesn't natively parse Waybar CSS, 
        # so we assume you have the .rasi version Pywal generates.
        
        font = "Inter 12";
        background-color = mkLiteral "transparent";
      };

      "window" = {
        width = mkLiteral "600px";
        height = mkLiteral "400px";
        border = mkLiteral "1px";
        border-color = mkLiteral "@foreground";
        border-radius = mkLiteral "2px";
        background-color = mkLiteral "@background";
      };

      "mainbox" = {
        padding = mkLiteral "32px";
        children = map mkLiteral [ "inputbar" "listview" ];
      };

      "inputbar" = {
        margin = mkLiteral "5px";
        padding = mkLiteral "8px";
        border-radius = mkLiteral "2px";
        background-color = mkLiteral "rgba(255, 255, 255, 0.05)";
        children = map mkLiteral [ "prompt" "entry" ];
      };

      "prompt" = {
        text-color = mkLiteral "@foreground";
        padding = mkLiteral "0px 10px 0px 0px";
      };

      "entry" = {
        text-color = mkLiteral "@foreground";
        placeholder = "....";
      };

      "listview" = {
        margin = mkLiteral "10px 0px 0px 0px";
        columns = 1;
        lines = 10;
        fixed-height = false;
      };

      "element" = {
        padding = mkLiteral "8px";
        border-radius = mkLiteral "2px";
      };

      "element selected" = {
        background-color = mkLiteral "@color1";
        text-color = mkLiteral "@background";
      };

      "element-icon" = {
        size = mkLiteral "24px";
        margin = mkLiteral "0px 12px 0px 0px";
      };

      "element-text" = {
        vertical-align = mkLiteral "0.5";
        text-color = mkLiteral "inherit";
      };
    };
  };
}
