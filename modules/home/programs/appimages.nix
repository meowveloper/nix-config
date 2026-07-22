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
in{
    home.packages = [
        esound
        esound-integration
        browseros
        browseros-integration
    ];
}
