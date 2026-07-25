{config,pkgs, ...}: 

{
boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5; 
  boot.loader.systemd-boot.consoleMode = "max";    
  boot.plymouth = {
    enable = true;
    theme = "breeze"; # Un thème propre et simple
  };  
  # Pour détecter Windows (si tu es en EFI)
  boot.loader.grub.useOSProber = true;

}