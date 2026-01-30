{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    shortcut = "s"; # Sets prefix to Ctrl-s
    mouse = true;
    baseIndex = 1;  # Start windows at 1 instead of 0
    escapeTime = 0; # Fix vim mode switching delay
    terminal = "tmux-256color";
    
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery false
          set -g @dracula-show-powerline true
          set -g @dracula-refresh-rate 10
        '';
      }
    ];

    extraConfig = ''
      # Vim-like pane navigation
      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

      # Status bar position
      set-option -g status-position bottom
    '';
  };
}
