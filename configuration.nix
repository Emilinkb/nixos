{ config, pkgs, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  imports = [
    ./hosts/laptop/hardware-configuration.nix
    ./modules/core/default.nix
    ./modules/core/security.nix  # <-- Add your security module here
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # Sway configuration with NVIDIA/Wayland support
  programs.sway = {
    enable = true;
    extraOptions = [ "--unsupported-gpu" ];
  };

  networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };

  services.syncthing = {
    enable = true;
    user = "emilienb";
    dataDir = "/home/emilienb/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
  };

  # Graphics / Mesa drivers (with 32-bit support)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Steam system module
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamescope.enable = true;
  programs.steam.gamescopeSession.enable = true;

  # Audio setup: PipeWire + WirePlumber session manager
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # XDG Desktop Portals for Sway
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };
}
