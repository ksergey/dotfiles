#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# apps
export EDITOR=vim
export FCEDIT=vim
export VISUAL=vim
if [ -n "$DISPLAY" ]; then
   export BROWSER=chromium
fi

# alias
alias ls='ls --color=auto'
alias grep='grep --color'
alias vi='vim'
alias view='vim -R'
alias lsblk='lsblk -o name,mountpoint,label,size,uuid'

# Helpers
# sudo pacreport --unowned-files | tee report.log
# pacman -Qo <file>

# history
export HISTCONTROL=ignoreboth
export HISTIGNORE='history*:ls:ls -la :ls -al :bg:fg:exit:pwd:clear:cd:cd ..:cd ~/:cd -:jobs'
shopt -s histappend

# Ignore me if I try to complete an empty line
shopt -s no_empty_cmd_completion

# auto completion
complete -cf sudo
complete -cf man
complete -cf pkill

# path
export LOCAL_PATH="${HOME}/.local"
export PATH="${LOCAL_PATH}/bin:${LOCAL_PATH}/scripts:${PATH}"
export PKG_CONFIG_PATH="${LOCAL_PATH}/lib/pkgconfig"
export BOOST_ROOT="${LOCAL_PATH}"

[[ -z "${XDG_CONFIG_HOME}"  ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -f "${HOME}/.dircolors" ]] && eval $(dircolors -b "${HOME}/.dircolors")

# color man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# creation mask
umask 022

# prompt
function setPs1 {
    # Don't expose Color* to env
    local Color1="\001\033[1;33m\002"
    local Color2="\001\033[0;90m\002"
    local Color3="\001\033[1;31m\002"
    local ColorR="\001\033[0m\002"
    export PS1="${Color1}\w ${Color2}[\h] [\A]\n${Color3}>${ColorR} "
}

setPs1
