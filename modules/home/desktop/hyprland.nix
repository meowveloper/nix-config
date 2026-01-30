{ pkgs, ... }: {
  # Hyprland Home Manager Module
  wayland.windowManager.hyprland = {
    enable = true;
    # We point to your specific config file
    extraConfig = builtins.readFile ../../../dot-files/.config/hypr/hyprland.conf;
  };

  # Manually mapping the rest of the hypr folder to keep subdirectories (src, dms)
  # We use the target name "hypr" so it ends up in ~/.config/hypr
  xdg.configFile."hypr/src".source = ../../../dot-files/.config/hypr/src;
  xdg.configFile."hypr/dms".source = ../../../dot-files/.config/hypr/dms;
  xdg.configFile."hypr/start-up.sh".source = ../../../dot-files/.config/hypr/start-up.sh;
  xdg.configFile."ghostty/config".source = ../../../dot-files/.config/ghostty/config;

  # Supporting packages for your Hyprland setup
  home.packages = with pkgs; [
    ghostty
  ];
}
