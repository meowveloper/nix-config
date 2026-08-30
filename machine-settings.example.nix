{
  # MACHINE SETTINGS (EXAMPLE TEMPLATE)
  # -----------------------------------
  # Run `cp machine-settings.example.nix machine-settings.nix`, then
  # discover each value and paste it into the matching field below.
  #
  #   - extraVolumeDevice / extraVolumeFsType: run `lsblk -f`, copy the
  #     UUID column into `/dev/disk/by-uuid/<uuid>`, and copy the FSTYPE
  #     column (ext4, btrfs, ...).
  #
  #   - gpu.driver: run `nvidia-smi`, copy the supported branch name
  #     (e.g. "latest", "stable", or "legacy_580" for older GPUs).
  #
  #   - gpu.intelBusId / gpu.nvidiaBusId: run
  #     `nix shell nixpkgs#pciutils -c lspci | grep -i -e vga -e 3d`,
  #     copy each address (e.g. `00:02.0`), convert dots to colons and drop
  #     leading zeros (`PCI:0:2:0`) for NVIDIA PRIME offload.
  #     (`lspci` is not installed by default — the `nix shell` one-liner
  #     provides it without changing your system. `nvidia-smi` also shows
  #     the NVIDIA address in its `Bus-Id` column.)
  #
  #   - maxJobs / cores: optional build caps — lower them on
  #     weak/throttled machines, raise them on strong ones.
  #
  #   - hostName: any hostname you choose for this machine.

  # Disk mount (see `lsblk -f` / `blkid`)
  extraVolumeDevice = "/dev/disk/by-uuid/<disk-uuid>";
  extraVolumeFsType = "<fs-type>"; # e.g. ext4, btrfs, xfs

  # GPU / NVIDIA config
  gpu = {
    enable = true; # set to false on machines WITHOUT an NVIDIA GPU
    intelBusId = "PCI:<x>:<y>:<z>";  # Intel iGPU bus id (from `lspci`)
    nvidiaBusId = "PCI:<x>:<y>:<z>"; # NVIDIA dGPU bus id (from `lspci`)
    driver = "<driver>";             # nvidiaPackages attr, e.g. "latest", "legacy_580"
  };

  # Build caps — tune to your CPU/thermal budget
  maxJobs = <n>;
  cores = <n>;

  hostName = "<hostname>";
}