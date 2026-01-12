{
  description = "Givtrah nix config because I'm a special snowflake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable"; # unstable nixpkgs
    nixpkgs-yuzu.url = "github:nixos/nixpkgs/95002f7"; # yuzu (have to be tested...)
    home-manager = { 
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-silicon = {
            url = "github:tpwrules/nixos-apple-silicon";
      #       url = "github:oliverbestmann/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?";
    };
    zotero-nix = {
      url = "github:camillemndn/zotero-nix";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
		walker = {
			url = "github:abenz1267/walker";
		};
		nur = {
			url = "github:nix-community/NUR";
			inputs.nixpkgs.follows = "nixpkgs";
    };
    cosmic-manager = {
			url = "github:HeitorAugustoLN/cosmic-manager";
			inputs = {
				nixpkgs.follows = "nixpkgs";
				home-manager.follows = "home-manager";
			};
		};



  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, apple-silicon, zotero-nix, walker, cosmic-manager, ... }@inputs:

    let
      specialArgs = { inherit inputs nixpkgs home-manager nix-flatpak zotero-nix walker; };
      overlays = [ inputs.neovim-nightly-overlay.overlays.default
      ];
      shared-modules = [
        {
          nix.settings = {
	                substituters = [ "https://nix-community.cachix.org/" ]; # nixos-cosmic build repo
	                trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
          };
        }
	home-manager.nixosModules.home-manager 
			({ config, ...}: {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
	  home-manager.extraSpecialArgs = { 
			inherit inputs nixpkgs zotero-nix walker; 
			inherit (config.networking) hostName; };	# make hostName inheritable for home-manager flakes
	  home-manager.users.ohm.imports = [ 
	    nix-flatpak.homeManagerModules.nix-flatpak
			walker.homeManagerModules.default
			cosmic-manager.homeManagerModules.cosmic-manager
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
	     home.stateVersion = "24.11";
	     imports = [ ]; 
	 };
	}
	];
      };

    };

  };
}




