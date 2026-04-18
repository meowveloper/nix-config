{ pkgs, ... }: {
    programs.dms-shell = {
        enable = true;

        systemd = {
            enable = true;
            restartIfChanged = true;
        };

        enableSystemMonitoring = true;
        enableVPN = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;
        enableCalendarEvents = true;
        enableClipboardPaste = true;

        plugins = {
            full-screen-power-menu = {
                src = pkgs.fetchFromGitHub {
                    owner = "JDKamalakar";
                    repo = "DMS-Fullscreen_Power_Menu";
                    rev = "main";
                    sha256 = "sha256-Q49P4ANfkIEvWzFPh4Wf4vL5ZvrYDjOEjr/L3r2ZicE=";
                };
            };
        };
    };
}
