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
      # General
      ripgrep
      fd
      gcc
      nodejs # Required for many LSPs

      # Lua
      lua-language-server
      stylua

      # Web Development
      vtsls # TypeScript
      vue-language-server # Vue (Volar)
      tailwindcss-language-server

      # Systems & Others
      clang-tools # C/C++ (clangd)
      zls # Zig
      dockerfile-language-server-nodejs
    ];
  };

  # Link the nvim folder in this git repo to ~/.config/nvim
  xdg.configFile."nvim".source = ./home/.config/nvim;
}
