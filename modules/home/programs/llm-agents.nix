{ pkgs, config, userSettings, inputs, ... }: {
    home.packages = [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.dsh
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.agent-browser
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
    xdg.configFile."opencode/opencode.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/opencode.jsonc";
    xdg.configFile."opencode/plugins".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/plugins";
    xdg.configFile."opencode/cli.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/cli.json";

    # dsh dot files — declarative: repo is source of truth,
    # `nixos-rebuild switch` restores these, wiping UI drift.
    # To add a plugin/MCP server: edit the dotfile, rebuild, DSH installs on launch.
    home.file.".dsh/settings.yaml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/settings.yaml";
    home.file.".dsh/dsh-mcp.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/dsh-mcp.json";
    home.file.".dsh/profiles/web/cordis.patch.yml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/profiles/web/cordis.patch.yml";
    home.file.".dsh/profiles/web/package.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/profiles/web/package.json";
    home.file.".dsh/profiles/web/pnpm-workspace.yaml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.dsh/profiles/web/pnpm-workspace.yaml";
    # NOTE: cordis.yml intentionally unmanaged — DSH generates it.
    # NOTE: never symlink .credentials.yaml, storages/, sessions/, node_modules, pnpm-lock.yaml.

    # global ".agents"
    home.file.".agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.agents";

    home.file.".local/bin/opencode".source = "${inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2}/bin/opencode2";

}
