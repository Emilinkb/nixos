#Import all file for boot

{config,pkgs, ...}: 

{
  imports = [
    ./users.nix
    ./network.nix
    ./boot.nix
    ./local.nix
    ./login.nix
    ../home/packages/sound.nix
  ];
  system.stateVersion = "26.05";
  
  programs.zsh.enable = true;
}