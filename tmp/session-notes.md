## tuis.nix — final: hybrid llm-agents + pkgs

- `opencode` (CLI) from `inputs.llm-agents.packages.${pkgs.system}.opencode`
- `opencode-desktop` from `pkgs.opencode-desktop`
- `xdg.dataFile` source updated to `${pkgs.opencode-desktop}/share/applications/opencode-desktop.desktop`

## flake.nix — final: llm-agents

- Replaced `opencode` input (`anomalyco/opencode`) with `llm-agents` (`numtide/llm-agents.nix`)
- Verified: `nix-instantiate --parse` passes
- NOTE: `modules/home/programs/tuis.nix` still references `inputs.opencode` and must be updated

## Hybrid Validation

- **Parse check** (`nix-instantiate --parse flake.nix`): PASSED
- **Package resolution** (`nix eval github:numtide/llm-agents.nix#packages.x86_64-linux.opencode.name`): `"opencode-1.17.13"`
- **Note**: `nix develop` wrapper skipped — flake has no `devShell` output. Commands run directly.

## nix-settings.nix

```nix
{ pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # this is to prevent from overheating during builds
    nix.settings = {
        # Limit the number of concurrent builds
        max-jobs = 4;
        # Limit the number of cores each build can use
        cores = 4;
        # Give the build process lower priority so your UI doesn't lag
        auto-optimise-store = true;
    };

    # Enable nix-ld to run unpatched binaries (like those installed by Mason)
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        stdenv.cc.cc
        zlib
        fuse3
        icu
        nss
        openssl
        curl
        expat
    ];

    zramSwap = {
        enable = true;
        priority = 100;
        algorithm = "zstd";
        memoryPercent = 200;
    };

}
```
