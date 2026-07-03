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
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };


  outputs = { self, nixpkgs, ... }@inputs:
    let
      # Obtain username from SOPS keyfile
      lib = nixpkgs.lib;
      keyFilePath = "/var/lib/sops-nix/keys.txt";
      # Read SOPS key file if it exists
      keyFileContent = if builtins.pathExists keyFilePath
        then builtins.readFile keyFilePath
        else throw ''
          [SOPS ERROR] Target file '${keyFilePath}' not found.
          Please create this file locally and format it like:
          # username: your_username
          AGE-SECRET-KEY-1...
        '';
      # split file into lines and find line with username
      lines = lib.strings.splitString "\n" keyFileContent; 
      usernameLine = lib.lists.findFirst 
        (line: lib.strings.hasPrefix "# username:" line) 
        (throw "Could not find '# username:' line in ${keyFilePath}") 
        lines;
      # strip prefix leaving just the username
      username = lib.strings.removeSuffix "\n" ( 
        lib.strings.removePrefix "# username: " usernameLine
      );
      debugMessage = ''=== Extracted Username: '${username}' === '';

      # Host dictionary with explicitly named Home-Manager state versions
      # system.stateVersion is defined inside each individual host directory!
      hosts = {
        taumac  = { system = "aarch64-linux"; homeManagerStateVersion = "24.05"; extraModules = [ inputs.apple-silicon.nixosModules.apple-silicon-support ]; };
        tausurf = { system = "x86_64-linux";  homeManagerStateVersion = "25.11"; extraModules = [ inputs.nixos-hardware.nixosModules.microsoft-surface-laptop-amd ]; };
        taupa   = { system = "x86_64-linux";  homeManagerStateVersion = "24.05"; extraModules = []; };
        taude   = { system = "x86_64-linux";  homeManagerStateVersion = "25.11"; extraModules = []; };
      };

      # Settings shared across all systems
      shared-modules = [
        inputs.home-manager.nixosModules.home-manager 
        inputs.sops-nix.nixosModules.sops
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
            inputs.sops-nix.homeManagerModules.sops
            ./home/default.nix
          ];
        })
      ];
    in 
      # Sanity check: Print out username everytime a rebuild is done
      builtins.trace debugMessage { 
      # Auto-generate the configuration for every host defined above
      nixosConfigurations = nixpkgs.lib.mapAttrs (hostName: hostData: nixpkgs.lib.nixosSystem {
        system = hostData.system;
        # Some systems require special module inherits 
        specialArgs = { inherit inputs nixpkgs username hostName; } 
          // nixpkgs.lib.optionalAttrs (hostName == "taumac") { inherit (inputs) apple-silicon; }
          // nixpkgs.lib.optionalAttrs (hostName == "tausurf") { inherit (inputs) nixos-hardware; };

        modules = shared-modules ++ hostData.extraModules ++ [
          ./hosts/${hostName} 
          {
            nixpkgs.overlays = [];
            # Assign the dictionary Home-manager state version
            home-manager.users.${username}.home.stateVersion = hostData.homeManagerStateVersion;
          }
        ];
      }) hosts;
    };
}
