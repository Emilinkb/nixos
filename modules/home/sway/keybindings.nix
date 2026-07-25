
{ config, pkgs, lib, ... }:

let
  mod = "Mod4"; 
  term = "${pkgs.alacritty}/bin/alacritty";
  menu = "${pkgs.rofi}/bin/rofi -show drun -show-icons -config ${./../rofi/config.rasi}";
  swaylockCmd = "${pkgs.swaylock-effects}/bin/swaylock --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5";
in
lib.mkOptionDefault {
  # 6. RACCOURCIS STANDARDS
  "${mod}+q" = "exec ${term}";
  "${mod}+c" = "kill"; # killactive
  "${mod}+m" = "exit";
  "${mod}+e" = "exec ${pkgs.nautilus}/bin/nautilus";
  "${mod}+v" = "floating toggle";
  "${mod}+space" = "exec ${menu}";
  
  "Mod1+space" = "exec web-search"; # ALT = Mod1
  "Shift+space" = "exec mytranslate";

  # Navigation entre les fenêtres
  "${mod}+Left" = "focus left";
  "${mod}+Right" = "focus right";
  "${mod}+Up" = "focus up";
  "${mod}+Down" = "focus down";

  # --- WORKSPACES AZERTY ---
  "${mod}+ampersand" = "workspace number 1";
  "${mod}+eacute"    = "workspace number 2";
  "${mod}+quotedbl"   = "workspace number 3";
  "${mod}+apostrophe" = "workspace number 4";
  "${mod}+parenleft"  = "workspace number 5";
  "${mod}+minus"      = "workspace number 6";
  "${mod}+egrave"     = "workspace number 7";
  "${mod}+underscore" = "workspace number 8";
  "${mod}+ccedilla"   = "workspace number 9";
  "${mod}+agrave"     = "workspace number 10";

  "${mod}+Shift+ampersand" = "move container to workspace number 1";
  "${mod}+Shift+eacute"    = "move container to workspace number 2";
  "${mod}+Shift+quotedbl"   = "move container to workspace number 3";
  "${mod}+Shift+apostrophe" = "move container to workspace number 4";
  "${mod}+Shift+parenleft"  = "move container to workspace number 5";
  "${mod}+Shift+minus"      = "move container to workspace number 6";
  "${mod}+Shift+egrave"     = "move container to workspace number 7";
  "${mod}+Shift+underscore" = "move container to workspace number 8";
  "${mod}+Shift+ccedilla"   = "move container to workspace number 9";
  "${mod}+Shift+agrave"     = "move container to workspace number 10";

  # Contrôle du Volume (wpctl)
  "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
  "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
  "XF86AudioMute"        = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

  # Luminosité (brightnessctl)
  "XF86MonBrightnessUp"   = "exec brightnessctl set 5%+";
  "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";

  # CAPTURES D'ÉCRAN (grim + slurp)
  "${mod}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
  "Shift+Print"    = "exec grim - | wl-copy && wl-paste > ~/Images/Screenshots/Full_Screenshot_$(date +%Y%m%d_%H%M%S).png";

  # Systèmes / Verrouillage (On utilise swaylock au lieu de hyprlock)
  "${mod}+l" = "exec grim /tmp/swaylock-bg.png && swaylock";
  "${mod}+s" = "exec swaylock --immediate & sleep 0.5 && systemctl suspend";

  # Raccourci Gemini !
  "Mod1+g" = "exec ${pkgs.chromium}/bin/chromium --app=https://gemini.google.com/app";
}