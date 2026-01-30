source /usr/share/cachyos-fish-config/cachyos-config.fish

alias ls='eza -l --color=auto --group-directories-first --icons=auto'
alias la='eza -la --color=auto --group-directories-first --icons=auto'
alias l='eza -laa --color=auto --group-directories-first --icons=auto'
alias tree='eza --tree'

alias cat='bat --style=plain'
alias grep='rg'
alias find='fd'

alias cd='z'
alias zi='z -i'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias df='duf'
alias top='btop'


export EDITOR=nvim
export VISUAL=nvim
export SUDO_EDITOR=nvim


function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function fish_greeting
	# nothing
end


zoxide init fish | source

source ~/.config/shell/user

