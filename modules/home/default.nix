{ pkgs, ... }: {
  imports = [
    ./programs
    ./desktop
  ];

  home.packages = with pkgs; [
    # Terminal Tools (Available everywhere)
    lazygit
    ripgrep
    fd
    fzf
    git
    
    # Development Basics
    gcc
    gnumake
    nodejs
  ];
}