#!/usr/bin/sh

sudo dnf install git neovim alacritty keepassxc nvtop python3-devel golang \
    nodejs nodejs-npm bat picom zsh adobe-source-code-pro-fonts fzf fd-find

git clone https://github.com/arttysh/dotfiles.git $HOME/Projects/dotfiles

rm -rf $HOME/.config/i3

ln -s $HOME/Projects/dotfiles/config/nvim $HOME/.config/nvim
ln -s $HOME/Projects/dotfiles/config/alacritty $HOME/.config/alacritty
ln -s $HOME/Projects/dotfiles/config/picom $HOME/.config/picom
ln -s $HOME/Projects/dotfiles/config/i3 $HOME/.config/i3

ln -s $HOME/Projects/dotfiles/zshrc $HOME/.zshrc
ln -s $HOME/Projects/dotfiles/zshenv $HOME/.zshenv

ln -s $HOME/Projects/dotfiles/tmux.conf $HOME/.tmux.conf
ln -s $HOME/Projects/dotfiles/tmux-sessionizer $HOME/.tmux-sessionizer

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

sudo dnf remove vim-minimal
sudo ln -s /usr/bin/nvim /usr/bin/vi
