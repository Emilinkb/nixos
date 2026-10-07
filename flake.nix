{
	description = "New Config nix v0.1";

	inputs = {
		nixpkgs.url ="github:nixos/nixpkgs/nixos-26.05";
		
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		zen-browser.url = "github:0xc000022070/zen-browser-flake";
        antigravity.url = "github:Hy4ri/antigravity-flake";
        	};

	outputs = { self, nixpkgs, home-manager,zen-browser,antigravity, ...}@inputs: {
		nixosConfigurations.EB_Thinkpad = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
                ({ pkgs, ... }: {
                    nixpkgs.overlays = [
                        (final: prev: {
                            # On extrait le paquet du flake et on le colle directement dans pkgs
                            antigravity-cli = inputs.antigravity.packages.${pkgs.system}.antigravity-cli;
                        })
                    ];
                })
		        ./hosts/desktop/hardware-configuration.nix
		        ./configuration.nix # <-- Vos modules système s'importent depuis ici (ex: core)

		        home-manager.nixosModules.home-manager
		        {
		          home-manager.useGlobalPkgs = true;
		          home-manager.useUserPackages = true;
		          home-manager.extraSpecialArgs = { inherit inputs; };
		          
		          # C'EST ICI ET UNIQUEMENT ICI que réside la configuration utilisateur :
		          home-manager.users.emilienb = import ./modules/home/home.nix; 
		        }
		      ];
		};
	};
}
