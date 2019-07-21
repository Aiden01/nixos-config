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
    loginScreenPath = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "Path to the wallpaper for the login screen";
    };
    differentWallpapers = mkOption {
      type = types.bool;
      default = true;
      description = "If you want to have a different wallpaper for the login screen and desktop";
    };
  };

  config = mkIf cfg.enable {
    assertions =
      [ { assertion = !cfg.differentWallpapers && cfg.loginScreenPath == null;
          message = "When option differentWallpapers is set to true, loginScreenPath must be present.";
        }
      ];
    systemd.user.services.wallpaper = {
      script = ''
      feh --bg-scale ${cfg.path}
      '';
      wantedBy = ["graphical-session.target"];
      partOf = ["graphical-session.target"];
    };

    services.xserver.displayManager.lightdm.background = if cfg.differentWallpapers
                                                         then builtins.toString cfg.loginScreenPath
                                                         else builtins.toString cfg.path;
    
  };
}
