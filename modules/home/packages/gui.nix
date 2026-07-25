{config, pkgs, inputs, ...}:

{
	home.packages = with pkgs;[

		#multimedia
		vlc
		tidal-hifi
		slurp


		#bureautique
		libreoffice
		gnome-calculator
		
		#dev
		sublime4

		#communication
		goofcord


		#navigateur
		inputs.zen-browser.packages."${pkgs.system}".default


	];
}
