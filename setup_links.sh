mkdir -p ~/.dotfiles/bin && ln -is bluetooth/bose_connect ~/.dotfiles/bin/bose_connect
mkdir -p ~/.dotfiles/android && ln -is ../corp/adebug ~/.dotfiles/android/adebug
mkdir -p ~/.dotfiles/android && ln -is ../corp/wm ~/.dotfiles/android/wm
mkdir -p ~/.oh-my-zsh/custom/themes && ln -is ~/.dotfiles/shell/vadim.zsh-theme ~/.oh-my-zsh/custom/themes/vadim.zsh-theme
mkdir -p ~/.config/kitty && ln -is ~/.dotfiles/kitty/colors.conf ~/.config/kitty/colors.conf
mkdir -p ~/.config/kitty && ln -is ~/.dotfiles/kitty/diff.conf ~/.config/kitty/diff.conf
mkdir -p ~/.config/kitty && ln -is ~/.dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
mkdir -p ~/.config/i3 && ln -is ~/.dotfiles/i3/config ~/.config/i3/config
mkdir -p ~/.config/i3 && ln -is ~/.dotfiles/i3/i3status ~/.config/i3/i3status
mkdir -p ~/.config && ln -is ~/.dotfiles/config/mpv ~/.config/mpv
mkdir -p ~/.config && ln -is ~/.dotfiles/picom.conf ~/.config/picom.conf
mkdir -p ~/.config && ln -is ~/.dotfiles/rofi ~/.config/rofi
mkdir -p ~/bin && ln -is ~/.dotfiles/bin/aanim ~/bin/aanim
mkdir -p ~/bin && ln -is ~/.dotfiles/bin/dc ~/bin/dc
mkdir -p ~/bin && ln -is ~/.dotfiles/bluetooth/bose_connect ~/bin/boseconnect
mkdir -p ~/bin && ln -is ~/.dotfiles/corp/ag ~/bin/ag
ln -is ~/.dotfiles/shell/.zshrc ~/.zshrc
ln -is ~/.dotfiles/shell/.tmux.conf ~/.tmux.conf
ln -is ~/.dotfiles/shell/.bashrc ~/.bashrc
ln -is ~/.dotfiles/shell/.bash_profile ~/.bash_profile
ln -is ~/.dotfiles/shell/.bash_aliases ~/.bash_aliases
ln -is ~/.dotfiles/mygitignore.txt ~/.personal_gitignore
ln -is ~/.dotfiles/i3/dunstrc ~/.dunstrc
ln -is ~/.dotfiles/i3/.conkyrc ~/.conkyrc
ln -is ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -is ~/.dotfiles/corp/xsecurelockrc ~/.xsecurelockrc
ln -is ~/.dotfiles/corp/android_env ~/.android_env
