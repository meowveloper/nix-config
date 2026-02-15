{ pkgs, ... }: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
  };

  # Mapping your existing starship.toml
  xdg.configFile."starship.toml".source = ../../../dot-files/programs/.config/starship.toml;
}
