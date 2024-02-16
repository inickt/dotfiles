# If you come from bash you might have to change your $PATH.
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

########################## oh-my-zsh options #########################

# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE=true

# Disable oh-my-zsh tab title, enable only directory name
DISABLE_AUTO_TITLE=true
ZSH_TAB_TITLE_ONLY_FOLDER=true
ZSH_TAB_TITLE_CONCAT_FOLDER_PROCESS=true

######################## end oh-my-zsh options #######################

######################## zgenom plugin manager #######################

# Look for changes to zsh config and auto reload plugins
ZGEN_RESET_ON_CHANGE=(${HOME}/.zshrc ${HOME}/.zshrc.local $([[ -f ${HOME}/.zshrc.macos ]] && echo ${HOME}/.zshrc.macos))

# Fuzzy fast jump
FZ_HISTORY_CD_CMD=zshz

# Disable forgit aliases
export FORGIT_NO_ALIASES=true

# enable iTerm2 shell integrations
zstyle :omz:plugins:iterm2 shell-integration yes
# Lazy load nvm
zstyle :omz:plugins:nvm lazy yes

# Load zgenom plugin manager
source "${HOME}/.zgenom/zgenom.zsh"

# Update plugins every 7 days, didable oh-my-zsh updates
zgenom autoupdate

# If the init script doesn't exist, create it
if ! zgenom saved; then
    # Plugins
    zgenom oh-my-zsh
    zgenom oh-my-zsh plugins/brew                             # brew env and completions
    zgenom oh-my-zsh plugins/git
    zgenom oh-my-zsh plugins/python
    zgenom oh-my-zsh plugins/sudo                             # double press escape to prepend sudo
    zgenom oh-my-zsh plugins/vundle
    zgenom oh-my-zsh plugins/urltools
    if hash tmux &>/dev/null; then
        zgenom oh-my-zsh plugins/tmux
    fi
    zgenom oh-my-zsh plugins/copypath
    zgenom oh-my-zsh plugins/colored-man-pages
    zgenom oh-my-zsh plugins/nvm

    # iTerm2 shell integration and utilities
    if [[ "$(uname -s)" = Darwin ]]; then
        zgenom oh-my-zsh plugins/iterm2
        zgenom bin gnachman/iTerm2-shell-integration --location utilities
    fi

    zgenom load agkozak/zsh-z                                 # fast jump
    zgenom load changyuheng/fz                                # fuzzy fast jump completion
    zgenom load wfxr/forgit                                   # fzf + git
    zgenom bin wfxr/forgit                                    # add forgit command to git
    zgenom load valentinocossar/vscode                        # aliases for Visual Studio Code
    zgenom load supercrabtree/k                               # Better ls with git status
    zgenom load zsh-users/zsh-completions src                 # More completions
    zgenom load zsh-users/zsh-autosuggestions                 # Fish-like fast autosuggestions
    zgenom load zdharma-continuum/fast-syntax-highlighting    # Better syntax highlighting
    zgenom load trystan2k/zsh-tab-title                       # Update tab title
    zgenom load romkatv/zsh-no-ps2                            # Disable PS2 for easier editing

    # Theme
    zgenom load woefe/git-prompt.zsh 

    # Generate the init script from plugins above
    zgenom save

    zgenom compile "$HOME/.zshrc"
    [[ -f $HOME/.zshrc.local ]] && zgenom compile "$HOME/.zshrc.local"
    [[ $OSTYPE == darwin* ]] && zgenom compile "$HOME/.zshrc.macos"
fi
###################### end zgenom plugin manager #####################

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

export LESS="-RI --tabs=4 --use-color"

# macOS specific config
[[ $OSTYPE == darwin* ]] && source $HOME/.zshrc.macos

# Local config
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# Forgit settings
export FORGIT_FZF_DEFAULT_OPTS="--height '100%'"
export FORGIT_LOG_GRAPH_ENABLE=false
export FORGIT_BLAME_GIT_OPTS="--date iso"

if type delta > /dev/null; then
    export DELTA_PAGER="less"
fi

if type bat > /dev/null; then
    export BAT_PAGER="less -F"
    export BAT_THEME="Monokai Extended Bright"
fi

# Show user readable file sizes by default
if type k > /dev/null; then       
    alias k="k -h"
fi

# VSCode shortcut
alias code="vs"

# Make sure git is setup
if [[ ! $(git config user.email) ]] || [[ ! $(git config user.name) ]]; then
   echo "\e[31m~/.gitconfig.local IS NOT CONFIGURED!!\e[0m" 
fi

# Python pretty print by default in REPL
export PYTHONSTARTUP="$HOME/.pythonstartup"

# set git commit -m highlighting to 72
FAST_HIGHLIGHT[git-cmsg-len]=72
