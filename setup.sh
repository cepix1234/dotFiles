# Arch install software needed
if [ "$EUID" -ne 0 ]; then
	echo "Run script as root."
	exit 1
fi

#echo "Installing necessary packages"
pacman --noconfirm -Syu neovim ghostty lazygit fish tmux lua git-delta luarocks wget fisher gcc go python ripgrep


#Symlink all dotfiles.
echo "Simbolic link dot files to ~/"
if [ -d ~/.tmux ] || [ -L ~/.tmux ]; then
	rm ~/.tmux.conf
    rm ~/.tmux.conf.local
fi
ln -s -f $(realpath .tmux)/.tmux.conf ~/
cp $(realpath .tmux)/.tmux.conf.local ~/

mkdir -p ~/.config
for dir in ./.config/*
do
 if [ -d ~/.config/$(basename $dir) ] || [ -L ~/.config/$(basename $dir) ]; then
	 rm -rf ~/.config/$(basename $dir)
 fi
 ln -s $(realpath $dir) ~/.config/
done


# dotnet
echo "Install latest dotnet"
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --version latest


# nvm
echo "Install nvm"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash


# fish nvm
echo "Install nvm fish plugin"
chmod +x fisherInstall.sh
fish fisherInstall.sh


# set default shell
echo "setting fish default shell"
if [[ $(grep -i Microsoft /proc/version) ]]; then
	echo /usr/bin/fish | tee -a /etc/shells
	chsh -s /usr/bin/fish
else
	echo /usr/local/bin/fish | tee -a /etc/shells
	chsh -s /usr/local/bin/fish
fi


# nvm
echo "Setup nvm default v22.17.1"
echo "v22.17.1" > ~/.nvmrc
