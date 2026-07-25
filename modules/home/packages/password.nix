{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    keepassxc
  ];

  xdg.configFile."keepassxc/keepassxc.ini".text = ''
    [Browser]
    Enabled=true
    Firefox=true
    CustomProxyLocation=false
  '';

  home.file = {
    # Option 1 : Le dossier Mozilla standard (souvent lu par Zen)
    ".mozilla/native-messaging-hosts/org.keepassxc.keepassxc_browser.json".source =
      "${pkgs.keepassxc}/share/keepassxc/browser/org.keepassxc.keepassxc_browser.json";

    # Option 2 : Le dossier Firefox spécifique
    ".firefox/native-messaging-hosts/org.keepassxc.keepassxc_browser.json".source =
      "${pkgs.keepassxc}/share/keepassxc/browser/org.keepassxc.keepassxc_browser.json";

    # Option 3 : Le dossier dédié à Zen Browser (selon la façon dont le paquet Zen est packagé sur votre NixOS)
    ".zen/native-messaging-hosts/org.keepassxc.keepassxc_browser.json".source =
      "${pkgs.keepassxc}/share/keepassxc/browser/org.keepassxc.keepassxc_browser.json";
  };
  
}