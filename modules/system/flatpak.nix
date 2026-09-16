{ config, pkgs, lib, ... }: let
  # services.flatpak.packages accepts both plain strings ("app.id")
  # and attrsets ({ appId = "app.id"; origin = "..."; }). Extract
  # the appId string from either form, skipping runtimes.
  flatpakAppIds = let
    getAppId = pkg: if builtins.isString pkg then pkg else pkg.appId;
    allIds = map getAppId config.services.flatpak.packages;
  in builtins.filter
    (id: !(lib.strings.hasPrefix "org.freedesktop.Platform" id))
    allIds;
in {
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

  # Grant Wayland + session bus access to Flatpak apps so they can use
  # the XDG Desktop Portal for screen sharing (ScreenCast portal).
  systemd.services.flatpak-screenshare-perms = {
    description = "Grant Flatpak screen sharing portal permissions";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = lib.strings.concatMapStringsSep "\n"
      (appId: "${pkgs.flatpak}/bin/flatpak override --system --socket=wayland --socket=session-bus ${appId}")
      flatpakAppIds;
  };
}
