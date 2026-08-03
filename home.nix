{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/modules";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    nvim = "nvim";
    qtile = "qtile";
    alacritty = "alacritty";
  };
in

{
  home.username = "yuta";
  home.homeDirectory = "/home/yuta";
  home.stateVersion = "26.05";
  
  programs.bash = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      ls = "eza --icons --color=always --group-directories-first -l";
      la = "eza --icons --color=always --group-directories-first -la";
      ff = "fastfetch";
      nrs = "sudo nixos-rebuild switch --flake /home/yuta/nixos-dotfiles#seetrace";
    };
    initExtra = ''
      export PS1="\[\e[38;2;140;170;238m\]╭─ 󱄅 \[\e[38;2;229;200;144m\]\u \[\e[38;2;166;209;137m\]@ \[\e[38;2;140;170;238m\]\w\n╰─❯ "
    '';
  };

  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "yuta";
        email = "seetrace@users.noreply.github.com";
      };
    };
  };
  
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  })
  configs;

home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
  ];
}
