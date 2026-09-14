{ pkgs, config, userSettings, inputs, ... }: {
    home.packages = [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.dsh
        pkgs.playwright-mcp
        pkgs.uv
        pkgs.pnpm
    ];

    systemd.user.services.opencode-web = {
        Unit = {
            Description = "OpenCode Web Server";
            After = [ "network.target" ];
        };

        Service = {
            Type = "simple";
            WorkingDirectory = config.home.homeDirectory;
            ExecStart = "${inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode}/bin/opencode web --port 4096 --hostname 0.0.0.0";
            Restart = "on-failure";
            RestartSec = "5";
            Environment = [ "PATH=${config.home.homeDirectory}/.local/bin:/run/current-system/sw/bin:/run/wrappers/bin" ];
        };
    };

    # opencode dot files
    xdg.configFile."opencode/agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/agents";
    xdg.configFile."opencode/skills".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/skills";
    xdg.configFile."opencode/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/AGENTS.md";
    xdg.configFile."opencode/opencode.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/opencode.jsonc";
    xdg.configFile."opencode/tui.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/tui.json";
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
}
