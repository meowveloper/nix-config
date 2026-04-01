{ pkgs, ... }: {
    programs.tmux = {
        enable = true;
        shortcut = "s"; # Sets prefix to Ctrl-s
        mouse = true;
        baseIndex = 1;  # Start windows at 1 instead of 0
        escapeTime = 0; # Fix vim mode switching delay
        terminal = "tmux-256color";

        plugins = with pkgs.tmuxPlugins; [
            # Removed static dracula theme to use Matugen colors
        ];

        extraConfig = ''
            # Source matugen colors
            if-shell "test -f ~/.config/tmux/colors.conf" "source-file ~/.config/tmux/colors.conf"

            # Keybindings
            bind-key h select-pane -L
            bind-key j select-pane -D
            bind-key k select-pane -U
            bind-key l select-pane -R

            bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"

            # UI Customization using Matugen Colors
            set-option -g status-position bottom
            set-option -g status-style "bg=#{@surface_container},fg=#{@on_surface_variant}"
            
            # Left side of status bar
            set -g status-left-length 50
            set -g status-left "#[bg=#{@primary},fg=#{@on_primary},bold] #S #[bg=default,fg=#{@primary}] "

            # Right side of status bar
            set -g status-right-length 100
            set -g status-right "#[fg=#{@primary}]#[bg=#{@primary},fg=#{@on_primary}] %Y-%m-%d %H:%M "

            # Window status
            set -g window-status-format "#[fg=#{@on_surface_variant}] #I: #W "
            set -g window-status-current-format "#[bg=#{@secondary},fg=#{@on_secondary},bold] #I: #W "
            set -g window-status-separator ""

            # Pane borders
            set -g pane-border-style "fg=#{@outline_variant}"
            set -g pane-active-border-style "fg=#{@primary}"

            # Message style
            set -g message-style "bg=#{@secondary_container},fg=#{@on_secondary_container}"
        '';
    };
}
