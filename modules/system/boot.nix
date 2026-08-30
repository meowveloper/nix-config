{ pkgs, lib, machineSettings, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = lib.mkIf machineSettings.gpu.enable [ "nvidia_drm.modeset=1" "nvidia_drm.fbdev=1" ];
}
