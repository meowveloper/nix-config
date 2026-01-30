{ pkgs, ... }: {
  # Burmese Fonts
  fonts.packages = with pkgs; [
    sil-padauk
    noto-fonts
    noto-fonts-cjk-sans
  ];

  # Add Burmese input tables to fcitx5
  i18n.inputMethod.fcitx5.addons = with pkgs; [
    fcitx5-table-extra
    fcitx5-gtk # Required for GTK app support
  ];
}
