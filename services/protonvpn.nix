{config, lib, ...}:
with lib;

let
  cfg = config.customModules.protonvpn;
in {
  imports = [
    (builtins.fetchTarball https://github.com/LightDiscord/protonvpn-nix/archive/master.tar.gz)
  ];
  options.customModules.protonvpn = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    services.openvpn.providers.protonvpn = {
      credentials = ../protonvpn-credentials;
      countries = [
        { region = "ca"; autoStart = true; }
      ];
    };
  };
}
