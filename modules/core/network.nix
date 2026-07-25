{config, pkgs, ...}: 

{
    networking.hostName = "Thinkpad";

    networking.networkmanager.enable = true;
    services.openssh = {
      enable = true;
      settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      };    
};
}
