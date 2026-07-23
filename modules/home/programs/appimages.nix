{ pkgs, ... }: let
    # === eSound ===
    esound-pname = "esound";
    esound-version = "3.0.3";
    esound-src = pkgs.fetchurl {
        url = "https://github.com/Spicy-Sparks/eSound-Desktop-Releases/releases/download/v3.0.3/eSound-3.0.3-x86_64.AppImage";
        hash = "sha256-KMFEc4iKVNfLNMzMGM2TmhcJbuoOvQ+5k2duly6FTXc=";
    };

    esound-appimage-contents = pkgs.appimageTools.extractType2 {
        pname = esound-pname;
        version = esound-version;
        src = esound-src;
    };

    esound = pkgs.appimageTools.wrapType2 {
        pname = esound-pname;
        version = esound-version;
        src = esound-src;
    };
    esound-desktop = pkgs.makeDesktopItem {
        name = "eSound";
        exec = "${esound}/bin/esound %U";
        icon = "esound";
        comment = "eSound Music Player";
        desktopName = "eSound Music";
        categories = [ "AudioVideo" ];
        mimeTypes = [ "x-scheme-handler/esoundmusic" ];
        startupWMClass = "eSound Music";
    };

    esound-integration = pkgs.runCommand "esound-integration" {}''
        mkdir -p $out/share/applications
        mkdir -p $out/share/icons/hicolor/512x512/apps
        cp -r ${esound-desktop}/share/applications/* $out/share/applications/
        cp ${esound-appimage-contents}/.DirIcon $out/share/icons/hicolor/512x512/apps/esound.png
    '';

    # === BrowserOS ===
    browseros-pname = "browseros";
    browseros-version = "latest";
    browseros-src = pkgs.fetchurl {
        url = "https://files.browseros.com/download/BrowserOS.AppImage";
        hash = "sha256-j17ERzRxTx/0OaKtSjp02DXi132Rfz9qse5uI7auu7s=";
    };

    browseros-appimage-contents = pkgs.appimageTools.extractType2 {
        pname = browseros-pname;
        version = browseros-version;
        src = browseros-src;
    };

    browseros = pkgs.appimageTools.wrapType2 {
        pname = browseros-pname;
        version = browseros-version;
        src = browseros-src;
    };
    browseros-desktop = pkgs.makeDesktopItem {
        name = "browseros";
        exec = "${browseros}/bin/browseros %U";
        icon = "browseros";
        comment = "The AI browser for humans";
        desktopName = "BrowserOS";
        categories = [ "Network" "WebBrowser" ];
        startupWMClass = "chromium-browser";
        mimeTypes = [ "text/html" "text/xml" "application/xhtml+xml" "x-scheme-handler/http" "x-scheme-handler/https" ];
    };

    browseros-integration = pkgs.runCommand "browseros-integration" {}''
        mkdir -p $out/share/applications
        mkdir -p $out/share/icons/hicolor/512x512/apps
        cp -r ${browseros-desktop}/share/applications/* $out/share/applications/
        cp ${browseros-appimage-contents}/browseros.png $out/share/icons/hicolor/512x512/apps/browseros.png
    '';

    # === Myanso ===
    myanso-pname = "myanso";
    myanso-version = "0.1.1";
    myanso-src = pkgs.fetchurl {
        url = "https://github.com/saturngod/myanso/releases/download/v0.1.1/Myanso-0.1.1.AppImage";
        hash = "sha256-d6VqgQ6pyez6fxmMvfAnTkg9mVmWOVvv9vQ+QwmpmQo=";
    };

    myanso-appimage-contents = pkgs.appimageTools.extractType2 {
        pname = myanso-pname;
        version = myanso-version;
        src = myanso-src;
    };

    myanso = pkgs.appimageTools.wrapType2 {
        pname = myanso-pname;
        version = myanso-version;
        src = myanso-src;
    };
    myanso-desktop = pkgs.makeDesktopItem {
        name = "myanso";
        exec = "${myanso}/bin/myanso %U";
        icon = "myanso";
        comment = "Terminal emulator with Myanmar script support";
        desktopName = "Myanso";
        categories = [ "System" "TerminalEmulator" ];
    };

    myanso-integration = pkgs.runCommand "myanso-integration" {}''
        mkdir -p $out/share/applications
        mkdir -p $out/share/icons/hicolor/512x512/apps
        cp -r ${myanso-desktop}/share/applications/* $out/share/applications/
        cp ${myanso-appimage-contents}/.DirIcon $out/share/icons/hicolor/512x512/apps/myanso.png
    '';
in{
    home.packages = [
        esound
        esound-integration
        browseros
        browseros-integration
        myanso
        myanso-integration
    ];
}
