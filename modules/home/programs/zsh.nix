{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # We can use Nix to manage your shell history settings
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
    };

    # Initialize extra configuration
    initExtra = ''
      # Load your existing aliases and profile
      [[ -f ~/.config/zsh-config/aliases ]] && source ~/.config/zsh-config/aliases
      [[ -f ~/.config/zsh-config/profile ]] && source ~/.config/zsh-config/profile

      # FZF and Zoxide integration (if you want them managed here or keep relying on your profile)
      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"

      # Yazi wrapper function
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d "" cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
      }
    '';
  };

  # Link your config files so the 'source' commands above work
  xdg.configFile."zsh-config/aliases".source = ../../../dot-files/.config/zsh-config/aliases;
  xdg.configFile."zsh-config/profile".source = ../../../dot-files/.config/zsh-config/profile;
}
