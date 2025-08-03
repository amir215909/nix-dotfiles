{ config, pkgs, ... }:

{
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    userName = "amir";
    userEmail = "ba97140@gmail.com";
  };

  programs.zsh.enable = true;

  home.packages = with pkgs; [
    htop
    neofetch
    starship
  ];

  programs.starship.enable = true;
  programs.starship.settings = {
    add_newline = false;
  };
}

