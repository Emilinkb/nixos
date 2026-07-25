{ config, pkgs, lib, ... }: 

{
  programs.zsh = {
    enable = true;
    
    initExtra = ''
      export KUBECONFIG="$HOME/.kube/config"
      export KREW_ROOT="$HOME/.krew"

      # NOTE SUR LES FLAKES : Avec les Flakes, NIX_PATH n'est plus strictement nécessaire,
      # mais vous pouvez le laisser si vous utilisez encore des commandes 'nix-env' ou 'nix-shell' classiques.
      export NIX_PATH="nixos-config=/etc/nixos:nixpkgs=nixpkgs"

      # Reconstruction du PATH
      export PATH="${pkgs.krew}/bin:${pkgs.nix}/bin:${pkgs.stdenv}/bin:${pkgs.bash}/bin:${pkgs.zsh}/bin:$KREW_ROOT/bin:$PATH"
    '' + (builtins.readFile ./neo.zsh-theme/neo.zsh-theme);
    
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
        "sudo"
        "kubectl"
        "helm"
        "docker"
        "sublime"
        "extract"
      ];
      theme = "";
    };
    
    shellAliases = {
      cl = "clear";
      ll = "ls -l";
      # Le nouvel alias adapté aux Flakes 🚀
      update = "sudo nixos-rebuild switch --flake /etc/nixos/#EB_Thinkpad"; 
    }; 
  };
}