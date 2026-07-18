{ ... }: {
  services.flatpak = {
    enable = true;
    packages = [
      "app.zen_browser.zen"
      "com.stremio.Stremio"
      "org.freedesktop.Platform.codecs-extra"
      "com.viber.Viber"
    ];
    remotes = [
      { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
    ];
    update = {
      onActivation = false;
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };
    uninstallUnmanaged = true;
    restartOnFailure.enable = true;
  };

  xdg.portal.enable = true;
}
