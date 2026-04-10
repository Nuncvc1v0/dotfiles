# Author: Nuncvc1v0

set fish_greeting

starship init fish | source
zoxide init fish | source

alias c="clear"

alias ls="eza --icons --group-directories-first"
alias lt="eza -la --icons --tree --level=2"
alias ll="eza -al --icons --group-directories-first --header"
alias tree="eza --tree --icons"
alias exa1='exa --tree --level=1'
alias exa2='exa --tree --level=2'
alias exa3='exa --tree --level=3'

alias cat="bat"
alias catp="bat --style=plain"

alias find="fd"
alias grep="rg"

alias top="btop"
alias htop="btop"

alias du="dust"
alias dud="dust -d 1"
alias dua="dua i"

alias json="jq ."

alias man="tldr"
alias help="tldr"
