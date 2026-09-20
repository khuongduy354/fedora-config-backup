#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

# User-specific environment (mirrors ~/.bashrc).
# Zsh's unique array keeps each PATH entry present only once.
typeset -U path PATH
path=("$HOME/.local/bin" "$HOME/bin" $path)
export PATH

# Load user-specific Zsh aliases and functions from ~/.zshrc.d.
if [[ -d "$HOME/.zshrc.d" ]]; then
    for rc in "$HOME"/.zshrc.d/*(N); do
        source "$rc"
    done
fi
unset rc

# Lightweight built-in color prompt.
PROMPT='%F{cyan}%n@%m%f:%F{blue}%~%f %# '

autoload -U compinit
compinit

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## keep background processes at full speed
#setopt NOBGNICE
## restart running processes on exit
#setopt HUP

## persistent, shared history
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

## search history using the text already typed when pressing Up/Down
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

## never ever beep ever
#setopt NO_BEEP

## automatically decide when to page a list of completions
#LISTMAX=0

## disable mail checking
#MAILCHECK=0

# autoload -U colors
#colors

# Convenience aliases
alias zcf='vi ~/.zshrc'
alias todevo='cd ~/developments/ongoing'
alias reboot-windows='sudo efibootmgr --bootnext 0000 && sudo systemctl reboot'
