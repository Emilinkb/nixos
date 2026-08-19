{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
  };

  home.packages = with pkgs; [
    swaylock-effects
    swayidle
    mako
    alacritty
    wl-clipboard
  ];
}