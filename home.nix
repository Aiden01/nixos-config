{ pkgs, ... }:

{
  # Packages
  home.packages = with pkgs; [
    wget
    vim
    git
    #emacs
    firefox
    zsh
    discord
    oh-my-zsh
    ghc
    stack
    cabal-install
    cabal2nix
    wakatime
    redshift
  ];



  # Services
  services = {
    redshift = {
      enable = true;
      provider = "geoclue2";
    };
  };

  # Packages configuration
  programs = {

    home-manager = {
     enable = true;
     path = "https://github.com/rycee/home-manager/archive/release-19.03.tar.gz";
    };

    git = {
      enable = true;
      userName = "aiden01";
      userEmail = "liangu@protonmail.com";
    };

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git" "sudo"];
        theme = "lambda";
      };
    };

    # emacs
    #emacs = {
    #  enable = true;
    #  extraPackages = epkgs: [
    #    epkgs.nix-mode
    #    epkgs.elcord
    #    epkgs.haskell-mode
    #  ];
    #};
  };
}