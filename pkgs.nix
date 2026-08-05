{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    eza # modern LS replacement
    fastfetch
    cutter
    vscodium
    htop
    ncdu
    tree
  ];
}
