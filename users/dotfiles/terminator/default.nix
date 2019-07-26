{ config, pkgs, lib, ... }:

with lib;

let
  terminatorConfig = builtins.readFile ./config;
  cfg = config.aiden.dotfiles.terminator;
in {
  options.aiden.dotfiles.terminator = {
    enable = mkEnableOption "dotfiles.terminator";
    extraConfig = mkOption {
      type = types.str;
      default = "";
      description = "Extra configuration for terminator";
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/terminator/config".text = terminatorConfig + cfg.extraConfig;
    home.packages = with pkgs; [ terminator ];
  };  
}
    
