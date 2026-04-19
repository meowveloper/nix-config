{ pkgs, lib, ... }: {
    programs.mango.enable = true;

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
        cliphist
        wl-clipboard
    ];
    programs.dconf.enable = true;
}
