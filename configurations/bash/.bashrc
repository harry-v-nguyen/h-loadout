#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias srcbash='source ~/.bashrc && echo ".bashrc reloaded!"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Git branch in PS1
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w \[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\n\$ '

# Tab completion / Readline enhancements
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'
bind 'set show-all-if-unmodified on'
bind 'set menu-complete-display-prefix on'
bind 'set completion-prefix-display-length 2'
bind 'set page-completions off'
bind 'set completion-query-items 200'
bind 'set visible-stats on'
bind 'set skip-completed-text on'
bind 'set colored-stats on'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# Starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# fzf for enhanced Ctrl+R reverse search
if command -v fzf &> /dev/null; then
  if [[ -f /usr/share/fzf/completion.bash ]]; then
    source /usr/share/fzf/completion.bash
  fi
fi

# Enhanced `ls` aliases using eza (if available)
if command -v eza &> /dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

export PATH=/home/harry/.opencode/bin:$PATH
