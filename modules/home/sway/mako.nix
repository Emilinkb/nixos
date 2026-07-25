{config, pkgs, ...}:


{
	services.mako = {
		enable = true;
		borderColor = "#00a19c";
        backgroundColor = "#00a19c";
        textColor = "#ffffff";
        borderRadius = 5;
        borderSize = 2;
        defaultTimeout = 3000;
	};
}