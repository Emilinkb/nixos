{config, pkgs, ...}:

{

	nix.settings.experimental-features = ["nix-command" "flakes"];
	imports = [
	./hosts/desktop/hardware-configuration.nix
	./modules/core/default.nix
	];

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];

	programs.sway.enable = true;

	networking.firewall = {
    allowedTCPPorts = [ 22000 ];
    allowedUDPPorts = [ 22000 21027 ];
  };

  services.syncthing = {
    enable = true;
    user = "emilienb";
    dataDir = "/home/emilienb/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
    # Vos dossiers partagés si vous souhaitez les déclarer ici...
  };

  
  # Enable OpenGL / Graphics drivers (with 32-bit support)
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

    # Enable PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # XDG Desktop Portals for Sway (wlroots)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

}








