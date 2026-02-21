{ ... }: {
  programs.fastfetch.enable = true;
  programs.gemini-cli.enable = true;
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  xdg.configFile."yazi/yazi.toml".source = ../../../dot-files/programs/.config/yazi/executable_yazi.toml;
  xdg.configFile."yazi/keymap.toml".source = ../../../dot-files/programs/.config/yazi/keymap.toml;
  xdg.configFile."yazi/launch.sh".source = ../../../dot-files/programs/.config/yazi/executable_launch.sh;
  xdg.configFile."fastfetch".source = ../../../dot-files/programs/.config/fastfetch;
}
