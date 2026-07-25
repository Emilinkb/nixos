{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true; # Lance Waybar automatiquement avec ta session

    settings = [{
      layer = "top";
      position = "top";
      height = 32;
      spacing = 4;
      modules-left = [ "sway/workspaces" "sway/mode" ];
      modules-center = [ "clock" ];
      modules-right = [ "pulseaudio" "network" "cpu" "memory" "battery" "tray" ];

      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
      };
      "clock" = {
        format = "🕒 {:%H:%M - %d/%m}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };
      "battery" = {
        format = "🔋 {capacity}%";
      };
      "network" = {
        format-wifi = "📶 {essid}";
        format-ethernet = "🔌 {ipaddr}";
        format-disconnected = "⚠️ Déconnecté";
      };
      "pulseaudio" = {
        format = "🔊 {volume}%";
      };

      "cpu" = {
        format = "🔲 {usage}%";
      };

      "memory" = {
        format = "➖ {used:0.1f}G/{total:0.1f}G";
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
      #battery, #cpu, #memory, #clock, #network, #pulseaudio {
          padding: 0 10px;
          margin: 4px 2px;
          background-color: #313244;
          color: #cdd6f4;
          border-radius: 6px;
      }
    '';
  };
}
