#!/bin/bash
# Script for install my softwares after a fresh install of lubuntu
# Beginning
clear
echo 
echo ====================
echo Beginning the process
echo ====================

echo setting variables 

# Packege to Install
echo Developers packages - SET
developers='virtualbox virtualbox-guest-additions-iso git gitk gitg vim vim-python-mode vim-addon-* terminator htop'

echo Network packages - SET
network='samba ssh remmina'

echo Internet packages - SET
internet='google-chrome-stable'

echo Video packages - SET
video='vlc mesa-utils calibre'

echo Backup packages - SET
backup='systemback'

echo Packages to Remove - SET
# Packages to Remove
packages_remove='gscan2pdf pidgin vim.tiny sylpheed'

echo Setting Repositores (Google, SystemBack) - SET
# add repos
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo add-apt-repository -y ppa:nemh/systemback

echo Updating APT
# Basic update
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

echo Download and Setting Dropbox
# Dropbox
cd ~ && wget -O dropbox "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf
wget -O ~/dropbox.py "https://raw.githubusercontent.com/toguko/my_rc_files/master/dropbox.py"
python ~/dropbox.py start -i
python ~/dropbox.py autostart -y

echo Removing packages
#Remove packages
sudo apt-get -y --force-yes remove $packages_remove

echo Installing all Packages
#Instaling packages
sudo apt -y --force-yes install $developers
sudo apt -y --force-yes install $network
sudo apt -y --force-yes install $internet
sudo apt -y --force-yes install $video
sudo apt -y --force-yes install $backup

echo Clean everything
# Clean everything
sudo apt-get -y --force-yes autoremove && sudo apt-get clean

echo setting files for Bash, Vim e Terminator
# Dotfiles section
# This section is dedicated to the dot files (.bash, .vimrc...) installed in your home folder.
# Adicionar aqui minha configuracao do vim no github igual abaixo

echo Setting Bash
wget -O ~/.bashrc "https://github.com/toguko/my_rc_files/blob/master/bash.bashrc"
wget -O ~/.dir_colors "https://raw.githubusercontent.com/toguko/my_rc_files/master/.dir_colors"
wget -O ~/.bash_profile "https://raw.githubusercontent.com/toguko/my_rc_files/master/.bash_profile"
echo 'Testing if .bashrc have force_color_prompt=yes'
teste='cat ~/.bashrc | grep '# force_color_prompt=yes''
if [ teste='# force_color_prompt=yes' ]; then echo force_color_prompt=yes >> ~/.bashrc; else echo "PULANDO"; fi

echo Setting Terminator
wget -O ~/.config/terminator/config "https://raw.githubusercontent.com/toguko/my_rc_files/master/terminator_config"

echo Setting VIM
wget -O ~/.vimrc "https://raw.githubusercontent.com/toguko/my_rc_files/master/.vimrc"

echo Erasing unused folders
# Erase folders
rm -rf ~/Documents
rm -rf ~/Public
rm -rf ~/Templates
rm -rf ~/Videos
rm -rf ~/Music
rm -rf ~/Pictures

# Prompt for a reboot
echo  ALL FINISHED
echo ====================
echo  TIME FOR A REBOOT! 
echo ====================