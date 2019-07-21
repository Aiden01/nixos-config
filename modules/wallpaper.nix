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
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.lightdm.background = toString (pkgs.fetchurl {
      url = https://w.wallhaven.cc/full/xl/wallhaven-xlpzqz.jpg;
      sha256 = "066z0j6zb6jbqdw2mgdr9456y58ni0n64zqdk6xz03hb84qysm6b";
    });
  };
}
