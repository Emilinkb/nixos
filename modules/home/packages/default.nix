{pkgs, ...}: 
{
    imports = [
        ./cli.nix
        ./dev.nix
        ./gui.nix
        ./password.nix
    ];    
}