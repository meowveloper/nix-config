{ pkgs, ... }: {
  programs.fastfetch.enable = true;
  programs.gemini-cli.enable = true;
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # Mapping your dotfiles to ~/.config/yazi/
  xdg.configFile."yazi/yazi.toml".source = ../../../dot-files/.config/yazi/executable_yazi.toml;
  xdg.configFile."yazi/keymap.toml".source = ../../../dot-files/.config/yazi/keymap.toml;
  xdg.configFile."yazi/launch.sh".source = ../../../dot-files/.config/yazi/executable_launch.sh;
  xdg.configFile."fastfetch".source = ../../../dot-files/.config/fastfetch;

}
