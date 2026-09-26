{ pkgs, lib, ... }: let
    # Pinned prebuilt binaries from upstream ComposioHQ/composio releases.
    # Follows the manual version+hash pin style of appimages.nix.
    version = "0.4.1";
    baseUrl = "https://github.com/ComposioHQ/composio/releases/download/%40composio/cli%400.4.1";

    # Per-platform CLI zips. Each zip contains `<name>/composio` (~100MB)
    # plus bundled services/adapters we deliberately do NOT install.
    srcs = {
        x86_64-linux = pkgs.fetchurl {
            url = "${baseUrl}/composio-linux-x64.zip";
            hash = "sha256-hspW5IO5MVWaAukOyKYqsTLCDZTlgiwdqxs7+F6r/QE=";
        };
        aarch64-linux = pkgs.fetchurl {
            url = "${baseUrl}/composio-linux-aarch64.zip";
            hash = "sha256-FomeIHhS8wjiOOmFqClQ98g95n+rcv9+GA3IbLMsMuU=";
        };
    };

    system = pkgs.stdenv.hostPlatform.system;

    composio-cli = pkgs.stdenvNoCC.mkDerivation {
        pname = "composio";
        inherit version;
        src = srcs.${system} or (throw "composio-cli 0.4.1 has no prebuilt binary for ${system} (only x86_64-linux and aarch64-linux are pinned)");

        nativeBuildInputs = [ pkgs.unzip ];

        # Extract just the CLI entrypoint, junking the zip's top-level dir.
        unpackPhase = ''
            runHook preUnpack
            unzip -j "$src" '*/composio'
            runHook postUnpack
        '';

        installPhase = ''
            runHook preInstall
            install -Dm755 composio "$out/bin/composio"
            runHook postInstall
        '';

        # Prebuilt binary runs via system nix-ld (enabled in nix-settings);
        # no autoPatchelf so the closure stays minimal.
        dontFixup = true;
    };

    # Skill zip wraps everything in a single `composio-cli/` dir holding
    # SKILL.md. Hoist its contents so the store dir itself IS the skill and
    # can be symlinked straight to ~/.agents/skills/composio-cli.
    composio-cli-skill = pkgs.stdenvNoCC.mkDerivation {
        pname = "composio-cli-skill";
        inherit version;
        src = pkgs.fetchurl {
            url = "${baseUrl}/composio-skill.zip";
            hash = "sha256-2Kl+li3bLfg91Hmz2i/VCc0E7E5RFZneBB4JyxT85MQ=";
        };

        nativeBuildInputs = [ pkgs.unzip ];

        installPhase = ''
            runHook preInstall
            unzip -o "$src" -d skill
            shopt -s dotglob
            mkdir -p "$out"
            mv skill/composio-cli/* "$out/"
            runHook postInstall
        '';
    };
in {
    home.packages = [ composio-cli ];

    # Skill lives in ~/.agents/skills/composio-cli (global, all agents)
    # instead of per-agent dirs, since ~/.agents is the shared entrypoint.
    # ~/.agents itself is a mkOutOfStoreSymlink to the mutable dotfiles
    # checkout, so home.file can't nest a store path inside it (collision:
    # HM would try to write through the symlink into the repo). Instead,
    # (re)point the skill dir on every activation — idempotent.
    # No `composio setup` / login runs here: agents stay unconfigured
    # until the user opts in manually.
    home.activation.linkComposioSkill = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        $DRY_RUN_CMD mkdir -p "$HOME/.agents/skills"
        $DRY_RUN_CMD ln -sfn "${composio-cli-skill}" "$HOME/.agents/skills/composio-cli"
    '';
}
