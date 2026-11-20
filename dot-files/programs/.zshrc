HISTSIZE="10000"
SAVEHIST="10000"
HISTFILE="$HOME/.zsh_history"
[[ -d ${HISTFILE:h} ]] || mkdir -p "${HISTFILE:h}"


eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  if cwd="$(<"$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}


if [[ $TERM != "dumb" ]]; then
  eval "$(starship init zsh)"
fi


ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)

[[ -f ~/.config/zsh-config/aliases ]] && source ~/.config/zsh-config/aliases
[[ -f ~/.config/zsh-config/profile ]] && source ~/.config/zsh-config/profile
[[ -f ~/.config/zsh-config/user ]] && source ~/.config/zsh-config/user

# Hermes Agent command
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac
