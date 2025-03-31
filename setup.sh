# Arch install software needed
echo "Installing necessary packages"
if [ "$EUID" -ne 0 ]; then
	echo "Run script as root."
	exit 1
else
	pacman --noconfirm -Syu neovim ghostty lazygit fish tmux lua git-delta luarocks wget fisher
fi

wait
# dotnet
echo "Install latest dotnet"
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --version latest


# golang
echo "Install golang v 1.20.6"
wget -q -O - https://git.io/vQhTU | bash


# nvm
echo "Install nvm"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash


# fish nvm
echo "Install nvm fish plugin"
fish
fisher install jorgebucaran/nvm.fish


# set default shell
echo "setting fish default shell"
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

#Symlink all dotfiles to .config 
echo "Simbolic link dot files to ~/"
if [ -d ~/.tmux ] || [ -L ~/.tmux ]; then
	rm -rf ~/.tmux
fi
ln -s $(realpath .tmux) ~/

for dir in ./.config/*
do
 if [ -d ~/.config/$(basename $dir) ] || [ -L ~/.config/$(basename $dir) ]; then
	 rm -rf ~/.config/$(basename $dir)
 fi
 ln -s $(realpath $dir) ~/.config/
done
