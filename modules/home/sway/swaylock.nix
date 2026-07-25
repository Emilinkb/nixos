{ config, pkgs, ... }:

{
  home.packages = [ pkgs.grim ];

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      screenshots = false;
      image = "/tmp/swaylock-bg.png";

      # Désactivation des textes et indicateurs de base
      clock = false;
      indicator = false;

      # Sécurité ultime : On rend absolument TOUT transparent (Alpha = 00)
      # Même si swaylock essaie d'afficher le rond, il sera invisible.
      inside-color = "00000000";
      inside-clear-color = "00000000";
      inside-caps-lock-color = "00000000";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";

      ring-color = "00000000";
      ring-clear-color = "00000000";
      ring-caps-lock-color = "00000000";
      ring-ver-color = "00000000";
      ring-wrong-color = "00000000";

      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";

      text-color = "00000000";
      text-clear-color = "00000000";
      text-caps-lock-color = "00000000";
      text-ver-color = "00000000";
      text-wrong-color = "00000000";

      # On cache aussi la clé de surbrillance de frappe
      key-hl-color = "00000000";
      bs-hl-color = "00000000";
    };
  };
}