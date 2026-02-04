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
    zoxide
    git
    bat
    
    # Development Basics
    gcc
    gnumake
    nodejs
    eza

    #others
    nautilus
    htop
  ];
}
