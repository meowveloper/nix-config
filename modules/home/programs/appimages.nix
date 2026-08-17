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

    # === Myanso ===
    myanso-pname = "myanso";
    myanso-version = "0.4.4";
    myanso-src = pkgs.fetchurl {
        url = "https://github.com/saturngod/myanso/releases/download/v0.4.4/Myanso-0.4.4.AppImage";
        hash = "sha256-d2oIHKZeNkJ9hclESLrxpmB35kK0YyBePZzV/v8eEMM=";
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
        myanso
        myanso-integration
    ];
}
