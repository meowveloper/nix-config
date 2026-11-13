{ pkgs, config, userSettings, inputs, ... }: {

    home.packages = [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.dsh
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.mcporter
        pkgs.uv
        pkgs.pnpm
        pkgs.node-gyp
    ];


    # for hermes computer use (Delete if not necessary)
    home.sessionVariables = {
        MCPORTER_CONFIG = "~/.config/mcporter/mcporter.json";
        CUA_DRIVER_RS_ENABLE_WAYLAND = "1";
    };

    home.sessionPath = [ "$HOME/.local/bin" ];

    xdg.configFile."mcporter".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/mcporter";

    # opencode dot files
    xdg.configFile."opencode/agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/agents";
    xdg.configFile."opencode/opencode.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/opencode.jsonc";
    xdg.configFile."opencode/plugins".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/plugins";
    xdg.configFile."opencode/cli.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/cli.json";


    # global ".agents"
    home.file.".agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.agents";

    home.file.".local/bin/opencode".source = "${inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2}/bin/opencode2";

    # dsh web — manual-start user service (no WantedBy: start/stop via aliases).
    # dsh has no `service` subcommand (only `web` + `plugin`), so systemd wraps it.
    # Default port 3080 comes from dsh-web-app's cordis.patch.yml.
    systemd.user.services.dsh-web = let
    in {
        Unit = {
            Description = "dsh web UI (DeepSeek Harness, manual start)";
            After = [ "network.target" ];
        };

        Service = {
            Type = "simple";
            ExecStart = "${pkgs.zsh}/bin/zsh -ic 'exec dsh web --no-open --port 3080'";
            WorkingDirectory = "%h";
            Restart = "no";
        };
    };

    # mcporter MCP HTTP bridge — always on so dsh/opencode can use
    # http://127.0.0.1:8931/mcp instead of spawning sandboxed stdio servers.
    # zsh -ic matches dsh-web: inherits MCPORTER_CONFIG + PATH from the shell env.
    systemd.user.services.mcporter-serve = {
        Unit = {
            Description = "mcporter MCP HTTP bridge (port 8931)";
            After = [ "network.target" ];
        };

        Service = {
            Type = "simple";
            ExecStart = "${pkgs.zsh}/bin/zsh -ic 'exec mcporter serve --http 8931'";
            WorkingDirectory = "%h";
            Restart = "on-failure";
            RestartSec = 2;
        };

        Install.WantedBy = [ "default.target" ];
    };

}
