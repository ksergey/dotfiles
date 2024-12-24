if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias lsblk='lsblk -o name,mountpoint,label,size,uuid'

set -gx EDITOR vim
set -gx VISUAL vim
