{ pkgs, config, lib, userSettings, inputs, ... }: {
    imports = [
        inputs.composio-nix.homeManagerModules.default
    ];

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

    # composio-cli (via composio-nix homeManagerModule).
    # Skill lives in ~/.agents/skills/composio-cli (global, all agents)
    # instead of per-agent dirs, since ~/.agents is the shared entrypoint.
    programs.composio-cli = {
        enable = true;
        agents = {
            opencode = false;
            claude = false;
            codex = false;
            cursor = false;
            kilocode = false;
            antigravity = false;
        };
    };

    # ~/.agents itself is a mkOutOfStoreSymlink to the mutable dotfiles
    # checkout, so home.file can't nest a store path inside it (collision:
    # HM would try to write through the symlink into the repo). Instead,
    # (re)point the skill dir on every activation — idempotent.
    home.activation.linkComposioSkill = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD mkdir -p "$HOME/.agents/skills"
        $DRY_RUN_CMD ln -sfn "${inputs.composio-nix.skills.composio-cli}" "$HOME/.agents/skills/composio-cli"
    '';

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
