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
      # "$@" forwards URLs from the desktop file (%U); empty when launched plain.
      if ${pkgs.curl}/bin/curl -s --connect-timeout 2 "$CDP_URL" >/dev/null 2>&1; then
        notify "Chromium Debug" "Debug browser already running — focusing it."
        exec "$CHROMIUM_BIN" --remote-debugging-port=9222 --new-window "$@"
      fi

      # Case B: normal Chromium alive but no CDP -> same-profile second
      # instance would hand off and never open CDP. Block instead.
      # NOTE: match the browser executable (argv[0]), never an argv
      # substring: `pgrep -f 'chrom(e|ium)'` false-positives on e.g. Zoom's
      # `zoommtg://...&browser=chrome` meeting URL. So pre-filter on a
      # binary-name boundary and then verify argv[0] itself.
      # Also skip our own PID, empty cmdlines (exited zombies), and any
      # launcher cmdline (`pgrep -f` also matches this script's own path).
      # No new nix deps: procps only (tr/head via PATH, like seq/sleep/nohup).
      chromium_found=0
      for pid in $(${pkgs.procps}/bin/pgrep -f '(^|/)(chromium|chrome|chromium-browser|google-chrome|headless_shell)( |$)' 2>/dev/null || true); do
          if [ "$pid" = "$$" ]; then
              continue
          fi
          argv0="$(tr '\0' '\n' < "/proc/$pid/cmdline" 2>/dev/null | head -n 1 || true)"
          case "$argv0" in
              ""|*chromium-debug-launch*) continue ;;
              */chromium|chromium|*/chrome|chrome|*/chromium-browser|chromium-browser|*/google-chrome|google-chrome|*/headless_shell|headless_shell) chromium_found=1; break ;;
              *) continue ;;
          esac
      done
      if [ "$chromium_found" = 1 ]; then
        notify -u critical "Chromium Debug blocked" "Close normal Chromium first, then retry."
        exit 1
      fi

      # Case C: nothing running -> launch detached (no --user-data-dir,
      # preserves real profile/logins) and wait for CDP.
      # "$@" forwards URLs from the desktop file (%U); empty when launched plain.
      nohup "$CHROMIUM_BIN" --remote-debugging-port=9222 --new-window "$@" >/dev/null 2>&1 &
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

in{
    # `desktop` links $out/share/applications/chromium-debug.desktop
    # directly; no separate copy derivation needed.
    home.packages = [
        launcher
        desktop
    ];
}
