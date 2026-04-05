{ lib, config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      allow_images = true;
      insensitve = true;
      prompt = "...."; 
      width = "600px";
			height = "400px";
#      lines = 10;
      dynamic_lines = false;
      location = "center";
      hide_scroll = true;
			matching = "strict-contains";
			parse_search = true;
			normal_window = true; # make wofi behave like a window, not a layer - to fix animations...
#      layer = "top"; # "top" is default, but "overlay" can be considered, but unsure what the difference is
    };
    
    style = ''
      /* Importing Pywal colors */
      @import url("file://$HOME/.cache/wal/colors-waybar.css");

      * {
        font-family: "Inter", "sans-serif"; /* Match your system font */
      }

      window {
        background-color: transparent;
      }

      #outer-box {
        margin: 5px;
        padding: 32px;
        background-color: @background;
        border: 1px solid alpha(@foreground, 0.1);
        border-radius: 2px;
        box-shadow: 0 19px 38px rgba(0, 0, 0, 0.3), 0 15px 12px rgba(0, 0, 0, 0.22);
      }

      #input {
        margin: 5px;
        padding: 8px;
        border: none;
        border-radius: 2px;
        background-color: alpha(@foreground, 0.05); /* Similar to 'lighter' background */
        color: @foreground;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1), 0 1px 2px rgba(0, 0, 0, 0.22);
      }

      #inner-box {
        background-color: transparent;
      }

      #scroll {
        margin-top: 10px;
      }

      #text {
        margin: 5px;
        color: @foreground;
        font-weight: 500;
      }

      #entry {
        padding: 8px;
        border-radius: 2px;
      }

      #entry:selected {
        background-color: alpha(@color1, 0.4);
      }

      #entry:hover {
        background-color: alpha(@color1, 0.2);
      }

      #img {
        margin-right: 12px;
      }

      /* Sub-text/Description style */
      #unselected #text {
         opacity: 0.8;
      }
    '';
  };
}

