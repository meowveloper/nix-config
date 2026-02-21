{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    adw-gtk3
  ];

  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
    };
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # Ensure the generated colors are imported
  xdg.configFile."gtk-3.0/gtk.css".text = ''
    @import 'colors.css';
  '';

  xdg.configFile."gtk-4.0/gtk.css".text = ''
    @import 'colors.css';
  '';
}
