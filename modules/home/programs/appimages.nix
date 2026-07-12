{ pkgs, ... }: let
    # === eSound ===
    esound-pname = "esound";
    esound-version = "2.8.8";
    esound-src = pkgs.fetchurl {
        url = "https://github.com/Spicy-Sparks/eSound-Desktop-Releases/releases/download/v2.8.8/eSound-Music-Setup-2.8.8.AppImage";
        hash = "sha256-+aJg12D9upKYqH5ZZS8RsGwjOiX/3TwAHMrRPjodfW8=";
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
in{
    home.packages = [
        esound
        esound-integration
    ];
}
