{pkgs, ...}:


{

	environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
	programs.sway = {

		enable = true;
		extraPackages = with pkgs; [
		swaylock-effects
		swayidle
		mako
		alacritty];
	};






}