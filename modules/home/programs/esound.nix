{ pkgs, ... }: let 
    pname = "esound";
    version = "2.8.8";
    esound = pkgs.appimageTools.wrapType2 {
        inherit pname version;
        src = pkgs.fetchurl {
          url = "https://github.com/Spicy-Sparks/eSound-Desktop-Releases/releases/download/v2.8.8/eSound-Music-Setup-2.8.8.AppImage";
          hash = "sha256-W6sx+Xj3ur3SalMzDbiLTwruU7/XdtH6foVckKw2p7o=";
        };
    };
    esound-desktop = pkgs.makeDesktopItem {
        name = "eSound";
        exec = "${esound}/bin/esound";
        icon = "esound";
        comment = "eSound Music Player";
        desktopName = "eSound";
        categories = [ "Audio" "Music" "Player" ];
    };
in{
    home.packages = [
        esound
        esound-desktop
    ];
}
