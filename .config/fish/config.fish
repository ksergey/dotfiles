if status is-interactive
    # Commands to run in interactive sessions can go here
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias lsblk='lsblk -o name,mountpoint,label,size,uuid'
    alias ncdu='ncdu --color=dark'
    alias myip='curl https://ipapi.co/json'

    set -gx EDITOR vim
    set -gx VISUAL vim
end
