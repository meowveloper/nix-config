{ ... }: {

    # Wayland desktop env. Keep only desktop-agnostic vars; the old
    # wlroots/MangoWM-specific GBM_BACKEND/WLR_NO_HARDWARE_CURSORS/
    # WLR_DRM_NO_ATOMIC/__GLX_VENDOR_LIBRARY_NAME vars are removed because
    # COSMIC does not use them and GBM_BACKEND=nvidia-drm can break the
    # Intel-primary + NVIDIA-PRIME setup. Games that need offload use the
    # `nvidia-offload` wrapper from hardware.nvidia.prime.offloadCmd.
    environment.variables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
    };

    # Required for clipboard managers (e.g. the cosmic-ext clipboard applet):
    # enables the wlr-data-control protocol so a background app can observe
    # every clipboard change. Tradeoff: any window can also read the clipboard.
    environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = "1";

}
