{pkgs, inputs, ...}:


{
	home.packages = with pkgs;[

	#editeur CLI
	vim
	nano



	#outil système
	git
	wget
	curl
	pciutils
	usbutils
	github-cli
	tldr
	broot
	bat
	eza
	ripgrep
	fd
	jq
	xdg-utils
	polkit_gnome
	openssl
	unzip


	#visualisation
	htop
	btop
	tree
	lazygit
	yazi
	fastfetch

	#archive
	unrar
	p7zip

	#ai
	pkgs.antigravity-cli
	translate-shell


	#commandlines
	kubectl
	kubernetes-helm
	docker
	docker-compose
	terraform
	terraform-docs
	google-cloud-sdk
	yubikey-manager
	];
}


