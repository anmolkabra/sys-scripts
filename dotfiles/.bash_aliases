
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias l="ls -AlFh"
alias ll='ls -alF'
alias la='ls -A'
alias ..="cd .."
alias c="clear"
alias htop="htop -d 5"
alias top="top -d 0.5"

function open () {
	xdg-open "$@" &>/dev/null
}

# for anyconnect vpn
alias vpn="/opt/cisco/anyconnect/bin/vpn"
alias vpnui="/opt/cisco/anyconnect/bin/vpnui"
