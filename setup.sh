# Arch install software needed
echo "Installing necessary packages"
sudo pacman -Syu neovim, ghostty, lazygit, fish, tmux, lua, git-delta, luarocks


# dotnet
echo "Install latest dotnet"
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmos +x ./dotnet-install.sh
./dotnet-install.sh --version latest


# golang
echo "Install golang v 1.20.6"
wget -q -O - https://git.io/vQhTU | bash


# fish fisher
echo "Install fisher"
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher


# nvm
echo "Install nvm"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash


# fish nvm
echo "Install nvm fish plugin"
fisher install jorgebucaran/nvm.fish


#Symlink all dotfiles to .config 
echo "Simbolic link dot files to ~/"
ln -s .tmux ~/
for dir in "./config"
do
 ln -s "./.config/$dir" ~/.config/
done
