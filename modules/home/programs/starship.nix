{ pkgs, ... }: {
  programs.starship = {
    enable = true;
  };

  # Mapping your existing starship.toml
  xdg.configFile."starship.toml".source = ../../../dot-files/programs/.config/starship.toml;
}
