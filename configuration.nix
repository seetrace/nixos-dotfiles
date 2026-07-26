{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking.hostName = "seetrace";
  networking.networkmanager.enable = true;
  
  nixpkgs.config.allowUnfree = true; # Im sorry Stallman, I have failed you :(

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true; # For open source kernel modules (like Stallman intended)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";
  
  services.xserver = {
    enable = true;
    xkb.layout = "no";
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    videoDrivers = [ "nvidia" ];
    windowManager.qtile.enable = true;
  };
  services.displayManager.ly.enable = true;
 
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.yuta = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    curl
    git
    alacritty
    feh
    openssh
    clang-tools
  ];
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "26.05"; # Did you read the comment?
}

