{ config, pkgs, ... }:

{
  # 1. Paquets nécessaires pour les menus et panneaux graphiques/TUI
  home.packages = with pkgs; [
    networkmanagerapplet # Fournit nm-connection-editor pour le WiFi/Réseau
    blueman              # Fournit blueman-manager pour le Bluetooth
    btop                 # Gestionnaire de tâches interactif pour le CPU/RAM
    swaynotificationcenter
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = [{
      layer = "top";
      position = "top";
      height = 32;
      spacing = 4;
      modules-left = [ "sway/workspaces" "sway/mode" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "bluetooth" "network" "cpu" "memory" "battery" "tray" ];

      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
      };

      "clock" = {
        format = "🕒 {:%H:%M - %d/%m}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "pulseaudio" = {
      "format" = "🔊 {volume}%";
      "on-click" = "swaync-client -t -sw"; # Ouvre/ferme le panneau de contrôle
      };

      "bluetooth" = {
        format = " {status}";
        format-connected = " {device_alias}";
        format-disabled = "󰂲 Off";
        tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connecté(s)";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connecté(s)\n\n{device_enumerate}";
        tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        on-click = "blueman-manager";        # Clic gauche : ouvre le gestionnaire Bluetooth
        on-click-right = "rfkill toggle bluetooth"; # Clic droit : On/Off Bluetooth
      };

      "network" = {
        format-wifi = "📶 {essid}";
        format-ethernet = "🔌 {ipaddr}";
        format-disconnected = "⚠️ Déconnecté";
        tooltip-format-wifi = "{essid} ({signalStrength}%)\nIP: {ipaddr}/{cidr}\nPasserelle: {gwaddr}";
        on-click = "nm-connection-editor";   # Clic gauche : éditeur de connexion WiFi/Ethernet
      };

      "cpu" = {
        format = "🔲 {usage}%";
        on-click = "alacritty -e btop";     # Clic gauche : moniteur de ressources
      };

      "memory" = {
        format = "➖ {used:0.1f}G/{total:0.1f}G";
        on-click = "alacritty -e btop";
      };

      "battery" = {
        format = "🔋 {capacity}%";
      };
    }];

    style = ''
      * {
          font-family: "JetBrainsMono Nerd Font", "DejaVu Sans Mono", sans-serif;
          font-size: 13px;
          border: none;
          border-radius: 0;
      }
      window#waybar {
          background-color: #1e1e2e;
          color: #cdd6f4;
      }
      #workspaces button {
          padding: 0 5px;
          background-color: transparent;
          color: #a6adc8;
      }
      #workspaces button.focused {
          background-color: #cba6f7;
          color: #11111b;
          border-radius: 4px;
      }
      #battery, #cpu, #memory, #clock, #network, #pulseaudio, #bluetooth, #tray {
          padding: 0 10px;
          margin: 4px 2px;
          background-color: #313244;
          color: #cdd6f4;
          border-radius: 6px;
      }
      #network:hover, #pulseaudio:hover, #bluetooth:hover, #cpu:hover, #memory:hover {
          background-color: #45475a;
      }
    '';
  };
}