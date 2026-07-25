{pkgs, ...}:

{


  # Activation de Greetd (Gestionnaire de connexion adapté à Wayland/Sway)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Lance tuigreet avec une horloge, et lui dit d'exécuter Sway après la connexion
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd sway";
        user = "greeter";
      };
    };
  };

  # Force Greetd à attendre que le terminal graphique (TTY) soit prêt
  systemd.services.greetd.serviceConfig.Type = "idle";

}