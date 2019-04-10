# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Look for changes to zsh config and auto reload plugins
ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc ${HOME}/.zshrc.local)

# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Load zgen plugin manager
source "${HOME}/.zgen/zgen.zsh"

# If the init script doesn't exist, create it
if ! zgen saved; then
    # Plugins
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/aws
    zgen oh-my-zsh plugins/thefuck
    zgen oh-my-zsh plugins/vundle
    zgen oh-my-zsh plugins/urltools
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/copydir
    zgen oh-my-zsh plugins/copyfile
    zgen load zdharma/zsh-diff-so-fancy
    zgen load unixorn/autoupdate-zgen
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-syntax-highlighting

    # Theme
    zgen oh-my-zsh themes/agnoster

    # Generate the init script from plugins above
    zgen save
fi

# Language environment
export LANG=en_US.UTF-8

if type bat > /dev/null; then       
    export BAT_PAGER="less -RF"
fi

if [[ ! $(git config user.email) ]] || [[ ! $(git config user.name) ]]; then
   echo "\e[31m~/.gitconfig.local IS NOT CONFIGURED!!\e[0m" 
fi


export LSCOLORS="ExFxBxDxCxegedabagacad"
export PYTHONSTARTUP="$HOME/.pythonstartup"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
