{ config, lib, ... }:
{
  imports = [
    ./terminator
  ];

  aiden.dotfiles = {
    terminator.enable = true;
  };
  
}
