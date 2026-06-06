{ inputs, pkgs, ... }:
let
  hermes = inputs.hermes-agent.packages.${pkgs.system}.full;
in
{
  home.packages = with pkgs; [
    hermes

    # Hermes companion packages
    nodejs_latest
    corepack
    typescript-language-server
    pandoc
    typst
    jq
    ripgrep
    go
    ffmpeg
    imagemagick
    zip
    himalaya
  ];
}
