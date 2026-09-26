{ pkgs, ... }: let
    # Pinned prebuilt binaries from upstream Tencent/BrowserSkill releases.
    # Follows the manual version+hash pin style of composio-cli.nix.
    # Resolved via https://github.com/Tencent/BrowserSkill/releases/latest/download/version.json
    # (tag cli-v0.3.1, released 2026-09-23). Hex sha256 from version.json
    # assets map converted to SRI; verified with `nix store prefetch-file --json <url>`.
    version = "0.3.1";
    tag = "cli-v${version}";
    baseUrl = "https://github.com/Tencent/BrowserSkill/releases/download/${tag}";

    # Per-platform musl-static tarballs. Each tarball contains a single
    # top-level `bsk` binary.
    srcs = {
        x86_64-linux = pkgs.fetchurl {
            url = "${baseUrl}/bsk-v${version}-x86_64-unknown-linux-musl.tar.gz";
            hash = "sha256-owEcl8w5/4WcWVaR+G8o9dJNYcNj1ZjMBv8Lu4MVyNs=";
        };
        aarch64-linux = pkgs.fetchurl {
            url = "${baseUrl}/bsk-v${version}-aarch64-unknown-linux-musl.tar.gz";
            hash = "sha256-Z//euMkM6h4DfIHfHii6zJWC5qkf5hues+sD2VH+b6U=";
        };
    };

    system = pkgs.stdenv.hostPlatform.system;

    browserskill = pkgs.stdenvNoCC.mkDerivation {
        pname = "bsk";
        inherit version;
        src = srcs.${system} or (throw "browserskill 0.3.1 has no prebuilt binary for ${system} (only x86_64-linux and aarch64-linux are pinned)");

        nativeBuildInputs = [ pkgs.gnutar ];

        # Tarball holds a single top-level `bsk`; default unpackPhase
        # (`tar -xzf $src`) suffices, kept explicit for clarity.
        unpackPhase = ''
            runHook preUnpack
            tar -xzf "$src"
            runHook postUnpack
        '';

        installPhase = ''
            runHook preInstall
            install -Dm755 bsk "$out/bin/bsk"
            runHook postInstall
        '';

        # Musl-static binary usually runs without patching; keep
        # dontFixup = true consistent with composio-cli.nix, with system
        # nix-ld (enabled in modules/system/nix-settings.nix) as fallback.
        dontFixup = true;
    };
in {
    # NOTE: upstream install.sh defaults to $HOME/.local/bin/bsk (via
    # $BSK_INSTALL_DIR) plus an `export PATH` line appended to
    # ~/.zshrc/~/.bashrc/~/.profile. That path is replaced here by the Nix
    # store path ($out/bin/bsk, exposed via home.packages), so no
    # sessionPath entry and no shell-rc edits are needed — Home Manager
    # owns the shell config.
    home.packages = [ browserskill ];

    # NOTE: the agent skill is NOT a static zip. It is generated at runtime
    # via `bsk install-skill --harness <id> --json` (needs network + the bsk
    # daemon), so nothing is symlinked in activation. Manual next steps
    # after rebuild:
    #   bsk --version
    #   bsk install-skill --list --json
    #   bsk install-skill --harness opencode   # or relevant harness id
    # plus: install the browser extension (Chrome/Edge links from the
    # BrowserSkill README) and note the daemon/BSK_HOME behavior.
}
