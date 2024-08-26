# Use the following block 
# case "$(uname)" in
#     Darwin*)
#         OS_ENV="mac"
#         ;;
#     Linux*)
#         OS_ENV="ubuntu"
#         ;;
#     *)
#         echo "Neither mac nor ubuntu!"
#         ;;
# esac

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

alias ..='cd ..'
alias back='cd -'
alias c="clear"
alias htop="htop -d 5"
alias top="top -d 0.5"
alias l='ls -AlFh'
alias la='ls -A'
alias ll='ls -alF'
alias tmn='tmux new -s'
alias tma='tmux attach -t'
alias tml='tmux ls'

case "$(uname)" in
    Darwin*) ;;
    Linux*)
        function open () {
            xdg-open "$@" &>/dev/null
        }

        function convert-pdf2png () {
            pdf_file="$1"
            png_file="${pdf_file%.*}.png"
            convert -density 300 ${pdf_file} -quality 90 ${png_file}
        }
        ;;
    *) ;;
esac

# for anyconnect vpn
case "$(uname)" in
    Darwin*)
        alias vpn="/opt/cisco/secureclient/bin/vpn"
        ;;
    Linux*)
        alias vpn="/opt/cisco/anyconnect/bin/vpn"
        alias vpnui="/opt/cisco/anyconnect/bin/vpnui"
        ;;
    *) ;;
esac
