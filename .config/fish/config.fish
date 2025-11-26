if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR vim
set -gx VISUAL vim

if status is-interactive
    if test $TMUX # could be "set -q TMUX"
        alias fzf="fzf --tmux"
    end
end

alias ls="/usr/bin/ls -l --group-directories-first --color=auto -h "
alias grep='grep --color=auto'
alias lsblk='lsblk -o name,mountpoint,label,size,uuid'
alias ncdu='ncdu --color=dark'
alias myip='curl https://ipapi.co/json'

starship init fish | source
