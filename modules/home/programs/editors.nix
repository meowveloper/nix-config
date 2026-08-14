{ pkgs, config, userSettings, ... }: {
    home.packages = with pkgs; [
        helix
        zed-editor-fhs

        #language servers
        nil
        nixd
        rust-analyzer
        typescript-language-server
        vue-language-server
        zls
    ];

    # neovim config
    xdg.configFile."nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/nvim/init.lua";
    xdg.configFile."nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/nvim/lua";
    xdg.configFile."neovide/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/neovide/config.toml";

    # zed config
    xdg.configFile."zed/settings.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/zed/settings.json";
    xdg.configFile."zed/keymap.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/zed/keymap.json";

    # helix config
    xdg.configFile."helix/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/helix/config.toml";
    xdg.configFile."helix/languages.toml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/helix/languages.toml";
    xdg.configFile."helix/themes".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/helix/themes";

    programs.neovide = {
        enable = true;
    };

    programs.helix = {
        enable = true;
    };

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        withRuby = false;
        withPython3 = false;

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
            # Rust tooling
            rustfmt
            clippy
            go
        ];
    };
}
