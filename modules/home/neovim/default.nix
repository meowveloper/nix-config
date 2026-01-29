{ pkgs, ... }: {
  # We disable the standard neovim module because nixCats will handle it
  programs.neovim.enable = false;

  # In the Home Manager module, the attribute is usually just 'nixCats'
  nixCats = {
    enable = true;
    packageNames = [ "nvim" ];
    luaPath = ../../../home/.config/nvim;

    categoryDefinitions.replace = ({ pkgs, ... }: {
      lspsAndRuntimeDeps = {
        general = with pkgs; [
          ripgrep
          fd
          gcc
          nodejs
          lua-language-server
          stylua
          vtsls
          vue-language-server
          tailwindcss-language-server
          clang-tools
          zls
          dockerfile-language-server-nodejs
        ];
      };
      startupPlugins = {
        general = [];
      };
    });

    packages.nvim = {
      enable = true;
      categories = {
        general = true;
      };
    };
  };
}
