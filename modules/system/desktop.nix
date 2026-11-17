{ config, pkgs, lib, machineSettings, ... }: lib.mkMerge [
    {
        # COSMIC desktop. Login is handled by cosmic-greeter (greetd-based,
        # Wayland); COSMIC itself is configured in the GUI, not in Nix.
        services.desktopManager.cosmic.enable = true;
        services.displayManager.cosmic-greeter.enable = true;
    }

    # GPU block must stay: NVIDIA/PRIME (Intel iGPU + MX350) is independent of
    # the desktop environment.
    (lib.mkIf machineSettings.gpu.enable {
        # for screen recorder plugin
        programs.gpu-screen-recorder.enable = true;
        hardware.graphics = {
            enable = true;
            extraPackages = with pkgs; [
                nvidia-vaapi-driver
                libva-vdpau-driver
                libva
            ];
        };
        hardware.nvidia = {
            package = config.boot.kernelPackages.nvidiaPackages.${machineSettings.gpu.driver};
            open = false;
            modesetting.enable = true;
            powerManagement.enable = true;
            prime = {
                offload.enable = true;
                # Provides the `nvidia-offload` wrapper, which sets the PRIME
                # render-offload env vars (incl. Vulkan optimus) and then execs
                # the command. Needed to run GPU-heavy apps on the MX350.
                offload.enableOffloadCmd = true;
                intelBusId = machineSettings.gpu.intelBusId;
                nvidiaBusId = machineSettings.gpu.nvidiaBusId;
            };
        };
        services.xserver.videoDrivers = [ "nvidia" ];
    })
]
