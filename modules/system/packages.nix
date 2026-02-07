{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    wget
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
    btop
    git-lfs
    chromium
  ];
}
