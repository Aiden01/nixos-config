{ config, lib, ... }:
{
  imports = [
    ./terminator
    ./alacritty
  ];

  aiden.dotfiles = {
    terminator.enable = true;
    alacritty.enable = false;
  };
  
}
