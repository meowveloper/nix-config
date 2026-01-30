{ pkgs, ... }: {
  imports = [
    ./nvim-wrapped.nix
    ./hyprland.nix
    ./yazi.nix
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
