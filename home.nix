{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/modules";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
in

{
  home.username = "yuta";
  home.homeDirectory = "/home/yuta";
  home.stateVersion = "26.05";
  
  programs.bash = {
    enable = true;
    shellAliases = {
      vim = "nvim";
      nrs = "sudo nixos-rebuild switch --flake /home/yuta/nixos-dotfiles#seetrace";
    };
    initExtra = ''
      feh --bg-fill /home/yuta/wp.jpg
      export PS1="\w "
    '';
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

  # temporary will be replaced with loops for optimizations
  xdg.configFile."qtile" = {
    source = create_symlink "${dotfiles}/qtile/";
    recursive = true;
  };
  
  xdg.configFile."nvim" = {
    source = create_symlink "${dotfiles}/nvim/";
    recursive = true;
  };
  
  xdg.configFile."alacritty" = {
    source = create_symlink "${dotfiles}/alacritty/";
    recursive = true;
  };

  home.packages = with pkgs; [
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    openssh
    feh
  ];
}
