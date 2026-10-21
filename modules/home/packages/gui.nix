{config, pkgs, inputs, ...}:

{
	nixpkgs.config.allowUnfree = true;
	home.packages = with pkgs;[

		#multimedia
		vlc
		tidal-hifi
		slurp
		vesktop
		fuzzel 


		#bureautique
		libreoffice
		gnome-calculator
		
		#dev
		sublime4
		vscode
		yubioath-flutter
		#communication
		goofcord


		#navigateur
		inputs.zen-browser.packages."${pkgs.system}".default

		#display
		wdisplays

		#email
		evolution
  		evolution-ews

  		#game
  		prismlauncher


	];
}
