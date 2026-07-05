{ pkgs, config, userSettings, inputs, ... }: {
  home.packages = [
    inputs.llm-agents.packages.${pkgs.system}.opencode
  ];

  xdg.dataFile."applications/opencode-desktop.desktop".source = "${pkgs.opencode-desktop}/share/applications/opencode-desktop.desktop";

  xdg.configFile."opencode/agents".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/agents";
  xdg.configFile."opencode/AGENTS.md".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/AGENTS.md";
  xdg.configFile."opencode/opencode.jsonc".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/programs/.config/opencode/opencode.jsonc";

  systemd.user.services.opencode-web = {
    Unit = {
      Description = "OpenCode Web Server";
      After = [ "network.target" ];
    };

    Service = {
      Type = "simple";
      WorkingDirectory = config.home.homeDirectory;
      ExecStart = "${inputs.llm-agents.packages.${pkgs.system}.opencode}/bin/opencode web --port 4096 --hostname 0.0.0.0";
      Restart = "on-failure";
      RestartSec = "5";
      Environment = [ "PATH=${config.home.homeDirectory}/.local/bin:/run/current-system/sw/bin:/run/wrappers/bin" ];
    };
  };
}
