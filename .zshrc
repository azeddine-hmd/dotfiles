# oh-my-zsh configuration
export ZSH="/home/azeddine/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh

# aliases
[ -f "$HOME/.config/aliases" ] && source "$HOME/.config/aliases"

# bindkeys
bindkey -s '^o' 'ranger\n'

[ -z "$TMUX" ] && tmux
