{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.customModules.i3;
in {
  options.customModules.i3 = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Wether to enable i3";
    };

    gaps = mkOption {
      type = types.bool;
      default = false;
    };
    
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.windowManager.i3 = {
      enable = true;
      package = mkIf cfg.enable pkgs.i3-gaps;
      # packages to be installed with i3
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
    services.xserver.windowManager.default = "i3";
  };
}
