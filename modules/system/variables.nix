{...}: {
    environment.variables = {
        EDITOR = "neovide";
        VISUAL = "neovide";
        MOZ_ENABLE_WAYLAND = "1";
        GBM_BACKEND = "nvidia-drm";
        WLR_NO_HARDWARE_CURSORS = "1";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        NIXOS_OZONE_WL = "1";
    };
}
