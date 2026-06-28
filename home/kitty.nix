{ config, pkgs, ... }:
{

  home.packages =
    with pkgs;

    [
    kitty-themes
    kitty-img

#    kitty # added here because I take care of configuration in normal dotfiles

    ];

    programs.kitty =
      let
       font_family = "JetBrainsMono NF";
      in
    {
      enable = true;
      font = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = font_family;
        size = 12;
      };

      keybindings = {
        "kitty_mod+s" = "paste_from_clipboard";
        "kitty_mod+v" = "paste_from_selection";
        "alt+shift+enter" = "clone-in-kitty --type=os-window";
      };
  
	    extraConfig = ''
        modify_font underline_position 2
        modify_font underline_thickness 200%
  
        modify_font cell_width 100%
        modify_font cell_height -1px

#				include ~/.cache/wal/colors-kitty.conf # already included due to programs.wal.enable = true in pywal16.nix? 
 
      '';

     settings = {
				bold_font = "${font_family} Bold";
        italic_font = "${font_family} Italic";
        bold_italic_font = "${font_family} Bold Italic";
  
        disable_ligatures = "cursor";
        copy_on_select = true;
  
        # fuck sounds
        enable_audio_bell = false;
        window_alert_on_bell = false;
        bell_on_tab = false;

				window_margin_width = 0;
        background_opacity = 0.9;

        adjust_line_height = "130%";

  #     # Window layout
        hide_window_decorations = "titlebar-only";
        window_padding_width = "10";

        # Tab bar
        tab_bar_edge = "top";
        tab_bar_style = "powerline";
        tab_title_template = "Tab {index}: {title}";
        active_tab_font_style = "bold";
        inactive_tab_font_style = "normal";
        tab_activity_symbol = "";

       allow_remote_control = "socket-only";
        listen_on = "unix:/tmp/kitty";
      };

      shellIntegration.enableBashIntegration = true;
      shellIntegration.mode = "enabled";
#      themeFile = "OneHalfDark"; # kinda stupid to do when using pywal16

      # https://github.com/kovidgoyal/kitty-themes/tree/master/themes

      #        env.TERM = "xterm-256color";

  };
}
