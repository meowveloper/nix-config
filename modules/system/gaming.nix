{ lib, machineSettings, ... }: lib.mkMerge [
    {
        # Steam + Proton. Skyrim has no native Linux port, so it runs through
        # Steam Play (Proton). The NVIDIA stack lives in mangowm.nix.
        programs.steam = {
            enable = true;
            # Adds a "Steam (gamescope)" session entry and the gamescope
            # wrapper, useful for NVIDIA + Wayland Proton quirks and scaling.
            gamescopeSession.enable = true;
        };

        # Feral GameMode: switches the CPU governor to performance and raises
        # process priority while a game runs, then restores it. Helps with the
        # thermal throttling on this laptop.
        programs.gamemode.enable = true;
    }

    (lib.mkIf machineSettings.gpu.enable {
        # Steam's client and Proton are 32-bit and need 32-bit graphics libs.
        # Depends on hardware.graphics.enable, set alongside the GPU in mangowm.nix.
        hardware.graphics.enable32Bit = true;
    })
]
