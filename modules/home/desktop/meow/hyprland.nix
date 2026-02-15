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
    brightnessctl
  ];

  xdg.configFile."hypr/src".source = ../../../../dot-files/meow/.config/hypr/src;
  xdg.configFile."hypr/hyprland.conf".source = ../../../../dot-files/meow/.config/hypr/hyprland.conf; 

  xdg.configFile."ghostty/config".source = ../../../../dot-files/meow/.config/ghostty/config;

  xdg.configFile."hypr/start-up.sh".source = "${hypr-startup-script}/bin/hypr-startup-script-sh";

  xdg.configFile."hypr/start-up.sh".executable = true;


}
