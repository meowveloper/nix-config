{ pkgs, ... }: let
  hypr-startup-script = pkgs.writeShellApplication {
    name = "hypr-startup-script-sh";
    text = builtins.readFile ../../../../dot-files/meow/.config/hypr/start-up.sh;
  };
in {
  home.packages = with pkgs; [
    ghostty
    kdePackages.polkit-kde-agent-1
    hyprshot
    grim
    slurp
    libnotify
    hypr-startup-script
  ];

  # Manually mapping the rest of the hypr folder to keep subdirectories (src, dms)
  xdg.configFile."hypr/src".source = ../../../dot-files/.config/hypr/src;
  xdg.configFile."hypr/dms/binds.conf".source = ../../../dot-files/.config/hypr/dms/binds.conf;
  xdg.configFile."hypr/dms/cursor.conf".source = ../../../dot-files/.config/hypr/dms/cursor.conf;
  xdg.configFile."hypr/dms/dank.conf".source = ../../../dot-files/.config/hypr/dms/dank.conf;
  xdg.configFile."hypr/dms/layout.conf".source = ../../../dot-files/.config/hypr/dms/layout.conf;
  xdg.configFile."hypr/dms/outputs.conf".source = ../../../dot-files/.config/hypr/dms/outputs.conf;
  xdg.configFile."hypr/hyprland.conf".source = ../../../dot-files/.config/hypr/hyprland.conf; 

  xdg.configFile."ghostty/config".source = ../../../dot-files/.config/ghostty/config;

  xdg.configFile."hypr/start-up.sh".source = "${hypr-startup-script}/bin/hypr-startup-script-sh";

  xdg.configFile."hypr/start-up.sh".executable = true;


}
