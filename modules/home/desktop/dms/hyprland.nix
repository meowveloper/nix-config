{ pkgs, ... }: let
  dms-hypr-startup-script = pkgs.writeShellApplication {
    name = "dms-hypr-startup-script-sh";
    text = builtins.readFile ../../../../dot-files/dms/.config/hypr/start-up.sh;
  };
in {
  home.packages = with pkgs; [
    ghostty
    kdePackages.polkit-kde-agent-1
    hyprshot
    grim
    slurp
    libnotify
    dms-hypr-startup-script
  ];

  # Manually mapping the rest of the hypr folder to keep subdirectories (src, dms)
  xdg.configFile."hypr/src".source = ../../../../dot-files/dms/.config/hypr/src;
  xdg.configFile."hypr/dms/binds.conf".source = ../../../../dot-files/dms/.config/hypr/dms/binds.conf;
  xdg.configFile."hypr/dms/cursor.conf".source = ../../../../dot-files/dms/.config/hypr/dms/cursor.conf;
  xdg.configFile."hypr/dms/dank.conf".source = ../../../../dot-files/dms/.config/hypr/dms/dank.conf;
  xdg.configFile."hypr/dms/outputs.conf".source = ../../../../dot-files/dms/.config/hypr/dms/outputs.conf;
  xdg.configFile."hypr/hyprland.conf".source = ../../../../dot-files/dms/.config/hypr/hyprland.conf; 
  
  # Replacement for the old start-up.sh
  xdg.configFile."hypr/start-up.sh".source = "${dms-hypr-startup-script}/bin/dms-hypr-startup-script-sh";
  xdg.configFile."hypr/start-up.sh".executable = true;

  xdg.configFile."ghostty/config".source = ../../../../dot-files/dms/.config/ghostty/config;

}
