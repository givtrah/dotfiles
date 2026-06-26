{
  description = "Givtrah nix config because I'm a special snowflake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    home-manager = { 
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?";
    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      username = "ohm"; # must be install username!

      # 1. Define your host data dictionary. 
      # Any unique hardware tweaks or specific state versions go here.
      hosts = {
        taumac  = { system = "aarch64-linux"; stateVersion = "24.05"; extraModules = [ inputs.apple-silicon.nixosModules.apple-silicon-support ]; };
        tausurf = { system = "x86_64-linux";  stateVersion = "25.11"; extraModules = [ inputs.nixos-hardware.nixosModules.microsoft-surface-laptop-amd ]; };
        taupa   = { system = "x86_64-linux";  stateVersion = "24.05"; extraModules = []; };
        taude   = { system = "x86_64-linux";  stateVersion = "25.11"; extraModules = []; };
      };

      # 2. Base set of settings shared across all systems
      shared-modules = [
        inputs.mangowm.nixosModules.mango
        inputs.home-manager.nixosModules.home-manager 
        ({ config, ... }: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { 
            inherit inputs nixpkgs username; 
            inherit (config.networking) hostName; 
          };
          home-manager.users.${username}.imports = [ 
            inputs.nix-flatpak.homeManagerModules.nix-flatpak
            ./home/default.nix
          ];
        })
      ];
    in {
      
      # 3. Use mapAttrs to loop over the 'hosts' data dictionary 
      # and auto-generate the complete configuration for every device.
      nixosConfigurations = nixpkgs.lib.mapAttrs (hostName: hostData: nixpkgs.lib.nixosSystem {
        system = hostData.system;
        
        # Pull extra inputs through specialArgs dynamically if needed
        specialArgs = { inherit inputs nixpkgs username; } 
          // nixpkgs.lib.optionalAttrs (hostName == "taumac") { inherit (inputs) apple-silicon; }
          // nixpkgs.lib.optionalAttrs (hostName == "tausurf") { inherit (inputs) nixos-hardware; };

        modules = shared-modules ++ hostData.extraModules ++ [
          ./hosts/${hostName} # Automatically imports ./hosts/taumac, ./hosts/taude, etc.
          {
            nixpkgs.overlays = [];
            home-manager.users.${username}.home.stateVersion = hostData.stateVersion;
          }
        ];
      }) hosts;

    };
}
