{ pkgs, ... }: {
  # Hyprland Home Manager Module
  wayland.windowManager.hyprland = {
    enable = true;
    # We point to your specific config file
    # Note: Using the Chezmoi name from your dot-files folder
    extraConfig = builtins.readFile ../../dot-files/.config/hypr/executable_hyprland.conf;
  };

  # Manually mapping the rest of the hypr folder to keep subdirectories (src, dms)
  # We use the target name "hypr" so it ends up in ~/.config/hypr
  xdg.configFile."hypr/src".source = ../../dot-files/.config/hypr/src;
  xdg.configFile."hypr/dms".source = ../../dot-files/.config/hypr/dms;
  xdg.configFile."hypr/start-up.sh".source = ../../dot-files/.config/hypr/executable_start-up.sh;

  # Supporting packages for your Hyprland setup
  home.packages = with pkgs; [
    swww        # Wallpaper
    matugen     # Material colors generation
    waybar      # Status bar
    rofi-wayland # App launcher
    hyprshot    # Screenshots (seen in your bindings)
    libnotify   # Notifications
    wl-clipboard # Clipboard support
  ];
}
