# Do all cloning & fetching under /tmp folder
cd /tmp

# -------------------------- Homebrew Package Managewr --------------------------
if ! brew -v > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

# Install oh-my-zsh & Powerline fonts
if [ -z "$(ls -A $HOME/.oh-my-zsh)" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
if [ -z "$(ls -A $HOME/Library/Fonts)" ]; then
    # clone
    cd /tmp
    git clone https://github.com/powerline/fonts.git --depth=1
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts
fi

# -------------------------- Programs --------------------------
#   Install alacritty
if ! command -v alacritty > /dev/null; then
    brew install alacritty --cask
    # Setup terminfo
        # Clone alacritty
    git clone https://github.com/alacritty/alacritty.git
    cd alacritty
        # setup terminfo
    sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
        # cleanup
    cd .. && rm -rf alacritty
fi

#   Install diff-so-fancy (git diff prettier)
if ! command -v diff-so-fancy > /dev/null; then
    brew install diff-so-fancy
fi

#   Install fzf
if [ ! -f ~/.fzf/install ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

#   Install bat
if ! command -v bat > /dev/null; then
    brew install bat
fi

#   Install exa
if ! command -v exa > /dev/null; then
    brew install exa
fi

#   Install ripgrep
if ! command -v rg > /dev/null; then
    brew install ripgrep
fi

#   Install fd
if ! command -v fd > /dev/null; then
    brew install fd
fi

#   Install tmux
if ! command -v tmux > /dev/null; then
    brew install tmux
fi

#   Install zplug
if [ ! -d ~/.zplug ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

# Install tpm
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# zplug Initialization/Update
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
else
    zplug update;
fi
