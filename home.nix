{ pkgs, ... }:

{
  # Packages
  home.packages = with pkgs; [
    wget
    vim
    git
    shutter
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
    alacritty
    arc-icon-theme
    arc-theme
    feh
    rustup
    gcc
    python36
    opam
    ocaml
    ocamlPackages.ocamlbuild
  ];



  # Services
  services = {
    redshift = {
      enable = true;
      # montreal
      latitude = "45.30";
      longitude = "73.35";
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
  };
}
