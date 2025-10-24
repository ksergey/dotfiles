if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR vim
set -gx VISUAL vim

if test -f /usr/bin/lsd
    alias ls "/usr/bin/lsd -l --group-directories-first -h "
else
    alias ls "/usr/bin/ls -l --group-directories-first --color=auto -h "
end

alias grep='grep --color=auto'
alias lsblk='lsblk -o name,mountpoint,label,size,uuid'
alias ncdu='ncdu --color=dark'
alias myip='curl https://ipapi.co/json'

starship init fish | source
