{ pkgs, ... }: let 
    pname = "esound";
    version = "2.8.8";
    src = pkgs.fetchurl {
        url = "https://github.com/Spicy-Sparks/eSound-Desktop-Releases/releases/download/v2.8.8/eSound-Music-Setup-2.8.8.AppImage";
        hash = "sha256-W6sx+Xj3ur3SalMzDbiLTwruU7/XdtH6foVckKw2p7o=";
    };

    appimage-contents = pkgs.appimageTools.extractType2 {
        inherit pname version src;
    };

    esound = pkgs.appimageTools.wrapType2 {
        inherit pname version src;
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
        cp ${appimage-contents}/.DirIcon $out/share/icons/hicolor/512x512/apps/esound.png
    '';
in{
    home.packages = [
        esound
        esound-integration
    ];
}
