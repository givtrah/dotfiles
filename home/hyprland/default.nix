{ inputs, lib, config, pkgs, username, hostName, ... }: { 

  # =========================================================================
  # USER CONFIGURATION (Home Manager Space)
  # =========================================================================
  home-manager.users.${username} = { ... }: {
    
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";
      systemd.enable = false;

      extraConfig = ''
        local home = os.getenv("HOME")
        package.path = package.path .. ";" .. home .. "/.config/hypr/?.lua"

        require("monitors")
        require("core")
        require("looknfeel")
        require("windows")
        require("keybindings")
        require("autostart")
      '';
    };

    xdg.configFile = {
      "hypr/core.lua".text        = builtins.readFile ./core.lua;
      "hypr/keybindings.lua".text = builtins.readFile ./keybindings.lua;
      "hypr/autostart.lua".text   = builtins.readFile ./autostart.lua;
      "hypr/looknfeel.lua".text   = builtins.readFile ./looknfeel.lua;
      "hypr/windows.lua".text     = builtins.readFile ./windows.lua;

      # FIXED: Per-host monitor file routing using native path coercion
      "hypr/monitors.lua".text = 
        let
          # Convert the string name dynamically into a true Nix path object
          expectedPath = ./. + "/monitors-${hostName}.lua";
        in
          if builtins.pathExists expectedPath 
          then builtins.readFile expectedPath
          else ''
            -- ==========================================
            -- FALLBACK DEFAULT MONITOR CONFIGURATION
            -- ==========================================
            hl.monitor({ name = "", resolution = "preferred", position = "auto", scale = "auto" })

            for i = 1, 5 do
              hl.workspace_rule({ workspace = tostring(i), persistent = true })
            end
          '';

      "uwsm/env".text = ''
        export QT_QPA_PLATFORM="wayland;xcb"
        export GDK_BACKEND="wayland,x11,*"
        export NIXOS_OZONE_WL="1"
      '';
    };

    home.packages = [
      (import ./scripts/wall-random.nix { inherit pkgs; })
      (import ./scripts/waybar-reload.nix { inherit pkgs; })
    ];

    imports = [
      ./hypridle.nix
      ./hyprlock.nix
      ./waybar.nix
      ./pywal16.nix
      ./rofi.nix
    ];
  };
}
