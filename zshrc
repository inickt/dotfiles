# If you come from bash you might have to change your $PATH.
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

######################### zgen plugin manager ########################
# Look for changes to zsh config and auto reload plugins
ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc ${HOME}/.zshrc.local)

# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Disable oh-my-zsh update checks- zgen takes care of it
DISABLE_AUTO_UPDATE=true

# Load zgen plugin manager
source "${HOME}/.zgen/zgen.zsh"

# If the init script doesn't exist, create it
if ! zgen saved; then
    # Plugins
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/autojump
    zgen oh-my-zsh plugins/thefuck
    zgen oh-my-zsh plugins/vundle
    zgen oh-my-zsh plugins/urltools
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/copydir
    zgen oh-my-zsh plugins/copyfile
    zgen load 'wfxr/forgit'
    zgen load valentinocossar/vscode             # aliases for Visual Studio Code
    zgen load supercrabtree/k                    # Better ls with git status
    zgen load zdharma/zsh-diff-so-fancy          # Fancy git diffs
    zgen load zsh-users/zsh-completions src      # More completions
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-syntax-highlighting

    # Theme
    zgen load woefe/git-prompt.zsh 

    # Generate the init script from plugins above
    zgen save
fi
####################### end zgen plugin manager ######################

############################### Prompt ###############################
# Prevent Python virtualenv from modifying the prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Set $psvar[12] to the current Python virtualenv
function _prompt_update_venv() {
    psvar[12]=
    if [[ -n $VIRTUAL_ENV ]] && [[ -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
        psvar[12]="${VIRTUAL_ENV:t}"
    fi
}
add-zsh-hook precmd _prompt_update_venv

# Git prompt settings
ZSH_GIT_PROMPT_FORCE_BLANK=1        # don't cache git status
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[default]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_no_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_no_bold[cyan]%}↓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_no_bold[cyan]%}↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}•"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[yellow]%}✚"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}⋯"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"

# Prompt settings
PROMPT=$'%F{7}┏╸%f'                  # start prompt symbol
PROMPT+=$'%F{12}%n@%m%f %B%~%b'      # user@hostname current-dir
PROMPT+='%(12V.%F{8} (%12v)%f .)'    # Python virtualenv name
PROMPT+=$'\n%F{7}┗╸%f'               # newline, other prompt symbol
PROMPT+=$'%(?.%F{blue}❯%f%F{cyan}❯%f%F{10}❯%f.%F{red}❯❯❯%f) '

RPROMPT=$'$(gitprompt)'              # async git on right prompt
PS2=$'%F{7}╺╸❯❯❯%f '                 # match PS1 arrows for PS2
############################# End Prompt #############################

# Language environment
export LANG=en_US.UTF-8

if type bat > /dev/null; then       
    export BAT_PAGER="less -RF"
fi

# Show user readable file sizes by default
if type k > /dev/null; then       
    alias k="k -h"
fi

# Make sure git is setup
if [[ ! $(git config user.email) ]] || [[ ! $(git config user.name) ]]; then
   echo "\e[31m~/.gitconfig.local IS NOT CONFIGURED!!\e[0m" 
fi

# Python pretty print by default in REPL
export PYTHONSTARTUP="$HOME/.pythonstartup"

# macOS specific config
[[ $OSTYPE == darwin* ]] && source ~/.zshrc.macos

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

