{ pkgs, config, userSettings, ... }: {
    xdg.configFile."nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/nvim/init.lua";
    xdg.configFile."nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/nvim/lua";
    xdg.configFile."neovide/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/neovide/config.toml";

    programs.neovide = {
        enable = true;
    };
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        # These packages will be available in Neovim's PATH. 
        # Mason-installed binaries will use nix-ld to run.
        extraPackages = with pkgs; [
            # Runtime / Compilers needed for plugins & Mason (Treesitter, downloading, etc.)
            tree-sitter
            unzip
            wget
            lua
            luajitPackages.luarocks-nix
            git
            gcc
            gnumake
            curl
            cargo
            go
        ];
    };
}
