{ pkgs, ... }: {
  # The state version Home Manager was installed with
  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Neovim Configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    # These dependencies will be available to Neovim
    extraPackages = with pkgs; [
      lua-language-server
      stylua
      ripgrep
      fd
      gcc
    ];
  };

  # Link the nvim folder in this git repo to ~/.config/nvim
  xdg.configFile."nvim".source = ./home/.config/nvim;
}
