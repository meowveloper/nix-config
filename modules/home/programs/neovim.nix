{ pkgs, config, userSettings, ... }: {
    xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/nvim";

    programs.neovim = {
        enable = true;
        defaultEditor = true;
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
