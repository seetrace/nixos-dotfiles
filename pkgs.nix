{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    eza # modern LS replacement
    fastfetch
  ];
}
