#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'
alias srcbash='source ~/.bashrc && echo ".bashrc reloaded!"'

export EDITOR='nvim'
export VISUAL='nvim'

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]: \[\033[01;34m\]\w \[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\n\$ '
