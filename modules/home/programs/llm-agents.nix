{ pkgs, config, userSettings, inputs, ... }: {
    home.packages = [
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode
        inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
    ];


    xdg.configFile."opencode/agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/agents";
    xdg.configFile."opencode/skills".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/skills";
    xdg.configFile."opencode/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/AGENTS.md";
    xdg.configFile."opencode/opencode.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/opencode.jsonc";
    xdg.configFile."opencode/tui.json".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/tui.json";

    home.file.".omp/agent/config.yml".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.omp/agent/config.yml";
    home.file.".omp/agent/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.omp/agent/AGENTS.md";
    home.file.".omp/agent/agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.omp/agent/agents";
    home.file.".omp/agent/managed-skills".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.omp/agent/managed-skills";

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
}
