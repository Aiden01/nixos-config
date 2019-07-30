{ config, pkgs, lib, ... }:

with lib;

let
  alacrittyConfig = builtins.readFile ./alacritty.yml;
  cfg = config.aiden.dotfiles.alacritty;
in {
  options.aiden.dotfiles.alacritty = {
    enable = mkEnableOption "dotfiles.alacritty";
    extraConfig = mkOption {
      type = types.str;
      default = "";
      description = "Extra configuration for alacritty";
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/alacritty/alacritty.yml".text = alacrittyConfig + cfg.extraConfig;
    home.packages = with pkgs; [ alacritty ];
  };
}
