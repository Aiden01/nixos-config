# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  env = import ./modules/env.nix {};
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
      ./modules/xmonad.nix
      ./modules/i3.nix
      ./services/wallpaper.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    home-manager
  ];


  # fonts configuration
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    fira-code
    twemoji-color-font
  ];

  environment.pathsToLink = env.path;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.compton.enable = true;

  # XServer
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";

    # Touchpad support (haven't been able to make it work yet)
    libinput = {
      enable = true;
      naturalScrolling = true;
      middleEmulation = true;
      tapping = true;
    };

    # Lightdm
    displayManager = {
      lightdm = {
        enable = true;
      };
    };

    desktopManager = {
      plasma5.enable = false;
      xterm.enable = false;
    };
  };

  # bluetooth
  hardware.bluetooth.enable = true;
  # Allows unfree packages to be installed
  nixpkgs.config.allowUnfree = true;

  # custom modules
  customModules = {
    i3 = {
      enable = true;
    };

    wallpaper = {
      enable = true;
      path = /home/aiden/.config/wallpapers/wallpaper.jpeg;
      differentWallpapers = false;
    };
  };
  users.users.aiden = {
    isNormalUser = true;
    home = "/home/aiden";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
