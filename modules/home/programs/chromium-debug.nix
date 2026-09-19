{ pkgs, ... }: let
    launcher = pkgs.writeShellScriptBin "chromium-debug-launch" ''
      set -u
      CDP_URL="http://127.0.0.1:9222/json/version"
      CHROMIUM_BIN="${pkgs.chromium}/bin/chromium"

      notify() {
        if command -v notify-send >/dev/null 2>&1; then
          notify-send "$@" || true
        fi
      }

      # Case A: debug instance already running -> focus it by re-invoking
      # with the same remote-debugging-port (opens tab/focuses, no duplicate daemon).
      if ${pkgs.curl}/bin/curl -s --connect-timeout 2 "$CDP_URL" >/dev/null 2>&1; then
        notify "Chromium Debug" "Debug browser already running — focusing it."
        exec "$CHROMIUM_BIN" --remote-debugging-port=9222
      fi

      # Case B: normal Chromium alive but no CDP -> same-profile second
      # instance would hand off and never open CDP. Block instead.
      # NOTE: `pgrep -f chromium` also matches this launcher itself
      # (cmdline contains "chromium-debug-launch"), so skip our own PID,
      # empty cmdlines (exited zombies), and any launcher cmdline.
      # No new nix deps: procps only (cat via PATH, like seq/sleep/nohup).
      chromium_found=0
      for pid in $(${pkgs.procps}/bin/pgrep -f 'chrom(e|ium)' 2>/dev/null || true); do
          if [ "$pid" = "$$" ]; then
              continue
          fi
          cmdline="$(cat "/proc/$pid/cmdline" 2>/dev/null || true)"
          case "$cmdline" in
              ""|*chromium-debug-launch*) continue ;;
              *) chromium_found=1; break ;;
          esac
      done
      if [ "$chromium_found" = 1 ]; then
        notify -u critical "Chromium Debug blocked" "Close normal Chromium first, then retry."
        exit 1
      fi

      # Case C: nothing running -> launch detached (no --user-data-dir,
      # preserves real profile/logins) and wait for CDP.
      nohup "$CHROMIUM_BIN" --remote-debugging-port=9222 >/dev/null 2>&1 &
      disown || true

      for i in $(seq 1 30); do
        if ${pkgs.curl}/bin/curl -s --connect-timeout 2 "$CDP_URL" >/dev/null 2>&1; then
          notify "Chromium Debug" "Debug browser ready on port 9222."
          exit 0
        fi
        sleep 2
      done

      notify -u critical "Chromium Debug failed" "CDP did not come up on port 9222."
      exit 1
    '';

    desktop = pkgs.makeDesktopItem {
        name = "chromium-debug";
        desktopName = "Chromium Debug";
        exec = "${launcher}/bin/chromium-debug-launch %U";
        icon = "chromium";
        comment = "Chromium with remote debugging on port 9222 for AI browser control";
        categories = [ "Network" "WebBrowser" ];
        terminal = false;
        startupWMClass = "chromium-browser";
    };

    integration = pkgs.runCommand "chromium-debug-integration" {}''
        mkdir -p $out/share/applications
        cp ${desktop}/share/applications/* $out/share/applications/
    '';

in{
    home.packages = [
        launcher
        integration
    ];
}
