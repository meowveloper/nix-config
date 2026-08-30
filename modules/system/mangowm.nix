{ config, pkgs, lib, inputs, machineSettings, ... }: lib.mkMerge [
    {
        programs.mango.enable = true;

        # greetd replaces the TTY login with a proper display manager.
        # This ensures the systemd user session starts with the correct
        # environment for xdg-desktop-portal-wlr.
        services.greetd = {
          enable = true;
          settings = {
            default_session = {
              command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd mango --env XDG_SESSION_TYPE=wayland";
              user = "greeter";
            };
          };
        };

        nix.settings = {
          extra-substituters = [ "https://noctalia.cachix.org" ];
          extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
        };

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
                intelBusId = machineSettings.gpu.intelBusId;
                nvidiaBusId = machineSettings.gpu.nvidiaBusId;
            };
        };
        services.xserver.videoDrivers = [ "nvidia" ];
    })
]
