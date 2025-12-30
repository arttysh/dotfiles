alias zsrc="source ~/.zshrc"
alias zedit="nvim ~/.zshrc"
alias zenv="nvim ~/.zshenv"

alias s="source env/bin/activate"
alias sb="source ../env/bin/activate"

alias ipy="python -m IPython"

alias pc="protonvpn-cli c"
alias pd="protonvpn-cli d"
alias ns="nmcli connection show"
alias nu="nmcli connection up nz.protonvpn.net.udp"
alias nd="nmcli connection down nz.protonvpn.net.udp"

alias tms="~/.tmux-sessionizer"
alias archwiki='firefox-developer-edition /usr/share/doc/arch-wiki/html/en/$(ls /usr/share/doc/arch-wiki/html/en/|fzf)'

alias t="tree -I env/ -I node_modules/"

# find process name from pid
alias psfind="ps -o comm= -p"
alias term="kill -SIGTERM"
alias h='tput cup $((LINES/2)) 0'
alias 2sh="~/.screenlayout/2-monitor.sh"

alias c="bat"

alias makes="make -s"

alias cat="bat"

gdoc() {
    go doc -src -all $1 | less
}
