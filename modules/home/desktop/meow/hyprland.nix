{ pkgs, config, userSettings, ... }: let
  meow-hypr-startup-script = pkgs.writeShellApplication {
    name = "meow-hypr-startup-script-sh";
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
    brightnessctl
    meow-hypr-startup-script
  ];

  xdg.configFile."hypr/src".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/hypr/src";
  xdg.configFile."hypr/hyprland.conf".source = config.lib.file.mkOutOfStoreSymlink "${userSettings.dotfiles_path}/meow/.config/hypr/hyprland.conf"; 

  xdg.configFile."ghostty/config".source = ../../../../dot-files/meow/.config/ghostty/config;

  xdg.configFile."hypr/start-up.sh".source = "${meow-hypr-startup-script}/bin/meow-hypr-startup-script-sh";

  xdg.configFile."hypr/start-up.sh".executable = true;


}
