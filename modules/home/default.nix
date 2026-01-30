{ pkgs, ... }: {
  imports = [
    # ./nvf.nix
    ./nvim-wrapped.nix
  ];

  home.packages = with pkgs; [
    # Terminal Tools (Available everywhere)
    yazi
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