{ pkgs, lib, ... }: {
    programs.mango.enable = true;

    # for screen recorder plugin
    programs.gpu-screen-recorder.enable = true;
    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            intel-media-driver
        ];
    };
    hardware.nvidia.open = false;
    services.xserver.videoDrivers = [ "nvidia" ];

    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
        ];
        config = {
            common.default = [ "gtk" ];
            mango.default = lib.mkForce [ "wlr" "gtk" ];
            wlroots.default = [ "wlr" "gtk" ];
        };
    };
    environment.systemPackages = with pkgs; [
        noctalia-shell

        # for clipper plugin
        cliphist
        wl-clipboard
    ];
    programs.dconf.enable = true;
}
