{ pkgs, config, userSettings, ... }: {
  # Symlink your existing AstroNvim config
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/nvim";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # These packages will be available in Neovim's PATH
    extraPackages = with pkgs; [
      # LSPs & Formatters
      lua-language-server
      stylua
      typescript-language-server
      vue-language-server
      nodePackages.vscode-langservers-extracted # HTML, CSS, JSON, ESLint
      tailwindcss-language-server
      zls # Zig
      clang-tools # C++, Clangd
      dockerfile-language-server      
      nixd
      deadnix
      statix

      # Runtime / Compilers needed for plugins (Treesitter, etc.)
      tree-sitter
      unzip
      wget
      lua
      luajitPackages.luarocks-nix
      git
      gcc
      gnumake
      curl
    ];
  };
}
