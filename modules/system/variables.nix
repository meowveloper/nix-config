{ lib, machineSettings, ... }: {
    environment.variables = lib.mkMerge [
        {
            EDITOR = "neovide";
            VISUAL = "neovide";
            MOZ_ENABLE_WAYLAND = "1";
            NIXOS_OZONE_WL = "1";
        }
        (lib.mkIf machineSettings.gpu.enable {
            GBM_BACKEND = "nvidia-drm";
            WLR_NO_HARDWARE_CURSORS = "1";
            WLR_DRM_NO_ATOMIC = "1";
            __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        })
    ];
}
