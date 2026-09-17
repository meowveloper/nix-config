{ pkgs, config, userSettings, inputs, ... }: {
    home.packages = [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.dsh
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.hermes-desktop
        pkgs.playwright-mcp
        pkgs.uv
        pkgs.pnpm
    ];


    # for hermes computer use (Delete if not necessary)
    home.sessionVariables = {
        CUA_DRIVER_RS_ENABLE_WAYLAND = "1";
    };

    home.sessionPath = [ "$HOME/.local/bin" ];

    # opencode dot files
    xdg.configFile."opencode/agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/agents";
    xdg.configFile."opencode/skills".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/skills";
    xdg.configFile."opencode/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/AGENTS.md";
    xdg.configFile."opencode/opencode.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/opencode.jsonc";
    xdg.configFile."opencode/plugins".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/plugins";
    xdg.configFile."opencode/archive".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/archive";
    xdg.configFile."opencode/cli.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/cli.json";

    # dsh dot files
    home.file.".dsh/settings.yaml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/settings.yaml";
    home.file.".dsh/skills".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/skills";
    home.file.".dsh/profiles/web/cordis.patch.yml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/profiles/web/cordis.patch.yml";
    home.file.".dsh/profiles/web/cordis.yml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/profiles/web/cordis.yml";
    home.file.".dsh/profiles/web/package.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/profiles/web/package.json";
    home.file.".dsh/profiles/web/pnpm-workspace.yaml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/profiles/web/pnpm-workspace.yaml";

    home.file.".local/bin/opencode".source = "${inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2}/bin/opencode2";
}
