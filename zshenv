alias zsrc="source ~/.zshrc"
alias zedit="nvim ~/.zshrc"
alias zenv="nvim ~/.zshenv"

alias v="nvim"
alias vim="nvim"

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
. "$HOME/.cargo/env"

# find process name from pid
alias psfind="ps -o comm= -p"
alias term="kill -SIGTERM"
alias h='tput cup $((LINES/2)) 0'
alias 2sh="~/.screenlayout/2-monitor.sh"

alias c="bat"

gdoc() {
    go doc -src -all $1 | less
}

nvuvm_reset() {
    sudo systemctl stop ollama.service
    sudo modprobe -r nvidia_uvm
    sudo modprobe nvidia_uvm
    sudo systemctl start ollama.service
}

# TODO: This is wrong. No time for today: 18-05-2024
proton_reinstall() {
    cd /home/artty/aur_packages
    if [ -d protonvpn-cli ]; then
        echo "updating protonvpn-cli"
        cd /home/artty/aur_packages
        sudo pacman -Rns protonvpn-cli
        rm protonvpn-cli -rf
        git clone https://aur.archlinux.org/protonvpn-cli.git
        cd protonvpn-cli
        makepkg -s
        sudo pacman -U *.zst
    fi

    cd /home/artty/aur_packages
    if [ -d python-protonvpn-nm-lib ]; then
        echo "updating python-protonvpn-nm-lib"
        cd /home/artty/aur_packages
        sudo pacman -Rns python-protonvpn-nm-lib
        rm python-protonvpn-nm-lib -rf
        git clone https://aur.archlinux.org/python-protonvpn-nm-lib.git
        cd python-protonvpn-nm-lib
        makepkg -s
        sudo pacman -U *.zst
    fi


    cd /home/artty/aur_packages
    if [ -d python-proton-client ]; then
        echo "updating python-proton-client"
        sudo pacman -Rns python-proton-client
        rm python-proton-client -rf
        git clone https://aur.archlinux.org/python-proton-client.git
        cd python-proton-client
        makepkg -s
        sudo pacman -U *.zst
    fi

}
