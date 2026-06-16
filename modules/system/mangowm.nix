{ pkgs, lib, inputs, ... }: {
    programs.mango.enable = true;

    nix.settings = {
      extra-substituters = [ "https://noctalia.cachix.org" ];
      extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
    };

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
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
        cliphist
        wl-clipboard
    ];
    programs.dconf.enable = true;
}
