#!/bin/sh

echo "Setting up for $SHELL"
time=$(date +"%Y-%m-%d-%H-%M-%S")

# Check for existing files and copy them
echo "Copying old files"
if [ -f ~/.vimrc ]; then
    cp ~/.vimrc ~/.vimrc_${time}
fi

if [ -f ~/.bash_profile ]; then
    cp ~/.bash_profile ~/.bash_profile_${time}
fi

if [ -f ~/.bash_aliases ]; then
    cp ~/.bash_aliases ~/.bash_aliases_${time}
fi

if [ -f ~/.bash_history ]; then
    cp ~/.bash_history ~/.bash_history_${time}
fi

if [ -f ~/.zshrc ]; then
    cp ~/.zshrc ~/.zshrc_${time}
fi


# Install the new config
echo "Installing new files"
cp vimrc ~/.vimrc
if [ $SHELL = '/usr/bin/bash' ]; then
    cp bash_profile ~/.bash_profile
    cp bash_aliases ~/.bash_aliases
elif [ $SHELL = '/usr/bin/zsh' ]; then
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cp zshrc ~/.zshrc
    cp aliases ~/.oh-my-zsh/custom/aliases.zsh
    cp history.zsh ~/.oh-my-zsh/custom/history.zsh
else
    echo "Must use /usr/bin/bash or /usr/bin/zsh"
fi

if [ "$(uname)" = "Darwin" ]; then 
    brew install fzf
    brew install ripgrep
elif [ "$(uname)" = "Linux" ]; then
    sudo apt-get install fzf ripgrep -y
fi

echo "done"
