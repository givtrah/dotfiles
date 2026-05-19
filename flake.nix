{
  description = "Givtrah nix config because I'm a special snowflake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; # unstable nixpkgs
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; # Nix hardware for surface laptop 4
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
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, nix-flatpak, apple-silicon, ... }@inputs:

    let
      specialArgs = { inherit inputs nixpkgs nixos-hardware home-manager nix-flatpak ; };
      overlays = [ 
      ];
      shared-modules = [
        {
#          nix.settings = {
#		extra-substituters = [ # NOT WORKING 2026-04-28
 #     			"https://nixos-apple-silicon.cachix.org"
  #  		];
   # 		extra-trusted-public-keys = [
    #  			"nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
   # 		];
#          };
        }
	home-manager.nixosModules.home-manager 
			({ config, ...}: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
	  home-manager.extraSpecialArgs = { 
			inherit inputs nixpkgs; 
			inherit (config.networking) hostName; };	# make hostName inheritable for home-manager flakes
	  home-manager.users.ohm.imports = [ 
	    		nix-flatpak.homeManagerModules.nix-flatpak
	    ./home/common.nix
          ];
	})
      ];

    in {
    
    nixosConfigurations = {

      # Macbook Air M2 (16 GB / 512 GB) - Nix OS unstable
      taumac = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = specialArgs // { inherit apple-silicon; };
        modules =  shared-modules ++ [
	  ./hosts/taumac
	  inputs.apple-silicon.nixosModules.apple-silicon-support
	  {nixpkgs.overlays = [];}
          home-manager.nixosModules.home-manager {
	    home-manager.users.ohm = {
	      home.stateVersion = "24.05";
	      imports = [ ];
	    };
	  }
	]; 
      };


# M$ Surface Laptop 4 (16 GB / 512 GB) - Nix OS unstable
      taumac = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = specialArgs // { inherit nixos-hardware; };
        modules =  shared-modules ++ [
	  ./hosts/tausurf
	  nixos-hardware.nixosModules.microsoft-surface-laptop-amd
	  {nixpkgs.overlays = [];}
          home-manager.nixosModules.home-manager {
	    home-manager.users.ohm = {
	      home.stateVersion = "25.11";
	      imports = [ ];
	    };
	  }
	]; 
      };





      
      # Main desktop @ uni 5700x 64 GB multi-GPU, 2 TB nvme - Nix OS unstable
      taupa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = specialArgs;
	modules = shared-modules ++ [
	  ./hosts/taupa
	  {nixpkgs.overlays = [];}
	  home-manager.nixosModules.home-manager { 
	    home-manager.users.ohm = {
	      home.stateVersion = "24.05";
	      imports = [ ]; 
	  };
	}
	];
      };

      # Main desktop @ home 7900 64 GB multi-GPU, lots of NVME / SSD
      taude = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	specialArgs = specialArgs;
	modules = shared-modules ++ [
	  ./hosts/taude
	  {nixpkgs.overlays = overlays; }
	 home-manager.nixosModules.home-manager { 
	   home-manager.users.ohm = {
	     home.stateVersion = "25.11";
	     imports = [ ]; 
	 };
	}
	];
      };

    };

  };
}




