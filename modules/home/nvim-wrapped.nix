{ pkgs, config, userSettings, ... }: {
  # Symlink your existing AstroNvim config
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.nvimconfigpath}";

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
      typescript-language-server
      vue-language-server
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
