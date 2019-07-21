{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.customModules.wallpaper;
in {
  options.customModules.wallpaper = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Wether to enable the wallpaper";
    };
    path = mkOption {
      type = types.path;
      description = "Path to the wallpaper";
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.wallpaper = {
      script = ''
      feh --bg-scale ${cfg.path}
      '';
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
    };
  };
}
