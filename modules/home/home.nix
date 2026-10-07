{config, pkgs, inputs, ...}:

{
	home.stateVersion = "26.05";
	imports = [
		./default.nix
	];
}
