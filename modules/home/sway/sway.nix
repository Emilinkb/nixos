{ config, pkgs, lib, ... }:

{

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    systemd.enable = true;
    
    
    # Configuration générale
    config = {
      modifier = "Mod4"; # $mainMod = SUPER
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.rofi}/bin/rofi -show drun -show-icons -config ${./../rofi/config.rasi}";

      # 1. MONITEURS
      output = {
        "*" = {
          
          bg = "/var/users/wallpapers/mercedes_japan.jpg fill";
        };
      };

      # 3. INPUT (Clavier principal fr + it)
      input = {
        "type:keyboard" = {
          xkb_layout = "fr,it";
          # Sway gère le basculement nativement. Exemple pour basculer avec Alt+Shift :
          # xkb_options = "grp:alt_shift_toggle";
        };
        # Layout spécifique pour votre Logitech MX Keys
        "1133:50434:Logitech_MX_Keys" = { # Note : il faudra vérifier l'ID exact via `swaymsg -t get_inputs`
          xkb_layout = "it";
        };
      };

      # 4. LOOK & FEEL (Sway est plus sobre, pas d'animations de flou complexes)
      gaps = {
        inner = 5;
        outer = 10;
      };

      bars = []; 

      # Couleurs des bordures (col.active_border)
      colors = {
        focused = {
          border = "#00a19c";
          background = "#00a19c";
          text = "#ffffff";
          indicator = "#00a19c";
          childBorder = "#00a19c";
        };
        unfocused = {
          border = "#1a1a1a";
          background = "#1a1a1a";
          text = "#888888";
          indicator = "#1a1a1a";
          childBorder = "#1a1a1a";
        };
      };

      # Chargement des raccourcis clavier depuis le fichier séparé
      keybindings = import ./keybindings.nix { inherit config pkgs lib; };
    };

    # 2. AUTO-START & ENV (Les exec-once d'Hyprland)
    extraConfig = ''
      # Note : swww et l'arrière plan sont déjà gérés plus haut par l'option 'output' de Sway, 
      # mais si vous préférez utiliser swww-daemon : exec swww-daemon
      exec pkill -x waybar
      exec /run/current-system/sw/libexec/polkit-gnome-authentication-agent-1
      
      # Thème du curseur
      seat * xcursor_theme Bibata-Modern-Ice 24
    '';
  };

  # Règles de fenêtres (Vos règles spécifiques pour Gemini)
  wayland.windowManager.sway.config.window.commands = [
    {
      command = "floating enable, resize set 1100 px 750 px, move position center";
      criteria = { title = "^Gemini$"; };
    }
  ];
}