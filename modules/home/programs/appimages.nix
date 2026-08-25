{ pkgs, ... }: let
    # === eSound ===
    esound-pname = "esound";
    esound-version = "3.0.3";
    esound-src = pkgs.fetchurl {
        url = "https://github.com/Spicy-Sparks/eSound-Desktop-Releases/releases/download/v3.0.3/eSound-3.0.3-x86_64.AppImage";
        hash = "sha256-KMFEc4iKVNfLNMzMGM2TmhcJbuoOvQ+5k2duly6FTXc=";
    };

    esound-appimage-contents = pkgs.appimageTools.extract {
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

in{
    home.packages = [
        esound
        esound-integration
    ];
}
