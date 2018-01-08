DEFAULT_USER=`whoami`
ZSH_THEME="agnoster"

export ZSH=/home/$DEFAULT_USER/.oh-my-zsh


plugins=(git python Multi-word zsh-256color docker docker-compose)

source $ZSH/oh-my-zsh.sh

# Aliases
source $HOME/.aliases
if [ -f $HOME/.aliases_work ]; then
    source $HOME/.aliases_work
fi

# User configuration
export LANG=en_US.UTF-8
export EDITOR='code'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# -------------------------- Zplug --------------------------
source ~/.zplug/init.zsh

# let zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Plugins
zplug "b4b4r07/enhancd", use:init.sh
zplug "hcgraf/zsh-sudo"
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "zlsun/solarized-man"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
