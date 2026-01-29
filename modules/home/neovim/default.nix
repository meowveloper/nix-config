{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      ripgrep
      fd
      gcc
      nodejs
      lua-language-server
      stylua
      vtsls
      vue-language-server
      tailwindcss-language-server
      clang-tools
      zls
      dockerfile-language-server-nodejs
    ];
  };

  # Point to your Lua config folder
  xdg.configFile."nvim".source = ../../../home/.config/nvim;
}
