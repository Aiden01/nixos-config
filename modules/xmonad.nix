{config, lib, pkgs, ...}:
with lib;

let
  # Get xmonad config from system configuration
  cfg = config.customModules.xmonad;
in {
  options.customModules.xmonad = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable xmonad";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };
    services.xserver.windowManager.default = "xmonad";
  };
}
