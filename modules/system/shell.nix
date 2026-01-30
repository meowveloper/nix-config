{ pkgs, ... }: {
  # Enable Zsh system-wide
  # This configures /etc/zshrc and ensures Zsh is in /etc/shells
  programs.zsh.enable = true;

  # Set Zsh as the default shell for all users
  users.defaultUserShell = pkgs.zsh;
}
