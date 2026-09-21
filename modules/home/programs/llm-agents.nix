{ pkgs, config, userSettings, inputs, ... }: {
    home.packages = [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.dsh
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.agent-browser
        pkgs.playwright-mcp
        pkgs.uv
        pkgs.pnpm
        pkgs.node-gyp
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


    # global ".agents"
    home.file.".agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.agents";

    home.file.".local/bin/opencode".source = "${inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2}/bin/opencode2";

    # dsh web — manual-start user service (no WantedBy: start/stop via aliases).
    # dsh has no `service` subcommand (only `web` + `plugin`), so systemd wraps it.
    # Default port 3080 comes from dsh-web-app's cordis.patch.yml.
    systemd.user.services.dsh-web = let
        dshPkg = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.dsh;
    in {
        Unit = {
            Description = "dsh web UI (DeepSeek Harness, manual start)";
            After = [ "network.target" ];
        };

        Service = {
            Type = "simple";
            ExecStart = "${dshPkg}/bin/dsh web --no-open --port 3080";
            WorkingDirectory = "%h";
            Restart = "no";
        };
    };

}
