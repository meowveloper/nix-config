{ pkgs, config, userSettings, ... }: {
    home.packages = with pkgs; [
        nil
        nixd
        rust-analyzer
        typescript-language-server
        vue-language-server
        zls
        cargo
    ];

    # neovim config
    xdg.configFile."nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/nvim/init.lua";
    xdg.configFile."nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/nvim/lua";
    xdg.configFile."neovide/config.toml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/neovide/config.toml";

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        withRuby = false;
        withPython3 = false;

        extraPackages = with pkgs; [
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
