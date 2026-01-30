{ pkgs, config, ... }: {
  # Symlink your existing AstroNvim config
  # NOTE: This path must be accessible within your VM/System.
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/mnt/extra-volume/projects/nix/arch-config/chezmoi/dank/dot_config/nvim";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # These packages will be available in Neovim's PATH
    extraPackages = with pkgs; [
      # Core Tools (Telescope, Yazi, etc.)
      ripgrep
      fd
      git
      fzf
      lazygit
      yazi

      # LSPs & Formatters
      lua-language-server
      stylua
      nodePackages.typescript-language-server
      nodePackages.vls # Vue
      nodePackages.vscode-langservers-extracted # HTML, CSS, JSON, ESLint
      tailwindcss-language-server
      zls # Zig
      clang-tools # C++, Clangd
      dockerfile-language-server-nodejs
      pyright # Python
      
      # Runtime / Compilers
      nodejs
      python3
      gcc
      gnumake
      unzip
      wget
      tree-sitter # For grammar compilation
    ];
  };
}