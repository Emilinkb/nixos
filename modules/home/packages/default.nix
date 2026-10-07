{pkgs, inputs, ...}: 
{
    imports = [
        ./cli.nix
        ./dev.nix
        ./gui.nix
        ./password.nix
	./nvim.nix
    ];    
}
