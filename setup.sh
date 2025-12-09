# Arch install software needed
if [ "$EUID" -ne 0 ]; then
	echo "Run script as root."
	exit 1
fi

echo "Installing necessary packages"
pacman --noconfirm -Syu neovim ghostty lazygit tmux lua git-delta luarocks wget gcc go python ripgrep fzf zsh nvm jq openssh

echo "Check en_US locales are generated"
enlocales="$(locale -a | grep en_US.utf8)"
if [[ -z "$enlocales" ]]; then
    echo "Generate en_US locales"
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
fi

# set default shell
echo "setting zsh default shell"
if [[ $(grep -i Microsoft /proc/version) ]]; then
	echo /usr/bin/zsh| tee -a /etc/shells
	chsh -s /usr/bin/zsh
else
	echo /usr/local/bin/zsh | tee -a /etc/shells
	chsh -s /usr/local/bin/zsh
fi

#Symlink all dotfiles.
echo "Simbolic link dot files to ~/"
echo "Simbolic link tmux config" 
if [ -d ~/.tmux ] || [ -L ~/.tmux ]; then
	rm ~/.tmux.conf
    rm ~/.tmux.conf.local
fi
ln -s -f $(realpath .tmux)/.tmux.conf ~/
cp $(realpath .tmux)/.tmux.conf.local ~/

echo "Simbolic link .config"
mkdir -p ~/.config
for dir in ./.config/*
do
 if [ -d ~/.config/$(basename $dir) ] || [ -L ~/.config/$(basename $dir) ]; then
	 rm -rf ~/.config/$(basename $dir)
 fi
 ln -s $(realpath $dir) ~/.config/
done

echo "Simbolic link bin"
mkdir -p ~/bin
for dir in ./bin/.*
do
 if [ -d ~/bin/$(basename $dir) ] || [ -L ~/bin/$(basename $dir) ]; then
	 rm -rf ~/bin/$(basename $dir)
 fi
 ln -s $(realpath $dir) ~/bin/
done
chmod +x ~/bin/.local/scripts/tmux-sessionizer
chmod +x ~/bin/.local/scripts/git-clone-bare-worktree.sh

echo "Simbolic link zsh"
for dir in ./zsh/.*
do
 if [ -d ~/$(basename $dir) ] || [ -L ~/$(basename $dir) ]; then
	 rm -rf ~/$(basename $dir)
 fi
 ln -s $(realpath $dir) ~/
done

echo "Simbolic link .tmux-sessionize"
ln -s $(realpath .tmux/.tmux-sessionizer) ~/

# dotnet
echo "Install latest dotnet"
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --channel 9.0
wget -qO- https://aka.ms/install-artifacts-credprovider.sh | bash

# git settins
git config --global core.editor "nvim"
git config --global merge.conflictstyle diff3

# nvm
echo "Install nvm"
source /usr/share/nvm/init-nvm.sh

echo "Setup nvm default v22.17.1"
echo "v22.17.1" > ~/.nvmrc
echo "Setup nvm default packages"
mkdir -p ~/.nvm
echo "corepack" > ~/.nvm/default-packages
echo "@adinsure-ops/ops-cli" >> ~/.nvm/default-packages
echo "@angular/cli" >> ~/.nvm/default-packages
echo "prettier" >> ~/.nvm/default-packages
echo "typescript" >> ~/.nvm/default-packages

#Git
echo "Adding clone-for-worktrees alias"
echo '[alias]' >> ~/.gitconfig
echo '	clone-for-worktrees = "!sh ~/bin/.local/scripts/git-clone-bare-worktree.sh"' >> ~/.gitconfig
