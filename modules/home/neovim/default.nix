{ pkgs, ... }: {
  # We disable the standard neovim module because nixCats will handle it
  programs.neovim.enable = false;

  programs.nixCats = {
    enable = true;
    # This creates a 'nvim' command. You can also name it 'neovim' or 'v'
    packageNames = [ "nvim" ];

    # Your Lua config folder
    luaPath = ../../../home/.config/nvim;

    # This is the "Nix side" of the bridge. 
    # We put all your binaries here.
    categoryDefinitions.replace = ({ pkgs, ... }: {
      lspsAndRuntimeDeps = {
        general = with pkgs; [
          # General
          ripgrep
          fd
          gcc
          nodejs

          # Lua
          lua-language-server
          stylua

          # Web Development
          vtsls
          vue-language-server
          tailwindcss-language-server

          # Systems
          clang-tools
          zls
          dockerfile-language-server-nodejs
        ];
      };
      
      # We can also handle plugins via Nix later if you want, 
      # but for now we'll let your Lua code handle them.
      startupPlugins = {
        general = [];
      };
    });

    # Tell nixCats which categories to enable for the 'nvim' package
    packages.nvim = {
      enable = true;
      categories = {
        general = true;
      };
    };
  };
}