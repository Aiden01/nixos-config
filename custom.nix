
{
  imports = [
    ./modules/xmonad.nix
    ./modules/i3.nix
    ./services/wallpaper.nix
    ./services/protonvpn.nix
  ];

  # custom modules
  customModules = {
    protonvpn = {
      enable = false;
    };
    i3 = {
      enable = true;
      gaps = true;
    };

    wallpaper = {
      enable = true;
      path = /home/aiden/.config/wallpapers/wallpaper.jpeg;
      differentWallpapers = false;
    };
  };
}
