# Directories:
mkdir -p ~/bin
mkdir -p ~/.config
mkdir -p ~/.config/Code/User
mkdir -p ~/.config/i3
mkdir -p ~/.config/kitty
mkdir -p ~/.oh-my-zsh/custom/themes
# Links:
ln -is ~/.dotfiles/bin/aanim ~/bin/aanim
ln -is ~/.dotfiles/bin/dc ~/bin/dc
ln -is ~/.dotfiles/bluetooth/bose_connect ~/bin/boseconnect
ln -is ~/.dotfiles/config/mpv ~/.config/mpv
ln -is ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -is ~/.dotfiles/git/mygitignore.txt ~/.personal_gitignore
ln -is ~/.dotfiles/i3/config ~/.config/i3/config
ln -is ~/.dotfiles/i3/.conkyrc ~/.conkyrc
ln -is ~/.dotfiles/i3/dunstrc ~/.dunstrc
ln -is ~/.dotfiles/i3/i3status ~/.config/i3/i3status
ln -is ~/.dotfiles/kitty/colors.conf ~/.config/kitty/colors.conf
ln -is ~/.dotfiles/kitty/diff.conf ~/.config/kitty/diff.conf
ln -is ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -is ~/.dotfiles/picom.conf ~/.config/picom.conf
ln -is ~/.dotfiles/rofi ~/.config/rofi
ln -is ~/.dotfiles/shell/.bash_aliases ~/.bash_aliases
ln -is ~/.dotfiles/shell/.bash_profile ~/.bash_profile
ln -is ~/.dotfiles/shell/.bashrc ~/.bashrc
ln -is ~/.dotfiles/shell/.profile ~/.profile.bak
ln -is ~/.dotfiles/shell/.tmux.conf ~/.tmux.conf
ln -is ~/.dotfiles/shell/vadim.zsh-theme ~/.oh-my-zsh/custom/themes/vadim.zsh-theme
ln -is ~/.dotfiles/shell/.zshrc ~/.zshrc
ln -is ~/.dotfiles/VSCode/keybindings.json ~/.config/Code/User/keybindings.json
ln -is ~/.dotfiles/VSCode/settings.json ~/.config/Code/User/settings.json
zsh ~/.dotfiles/corp/setup_links.sh
