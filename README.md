# Nick's Dotfiles

## Includes

- zsh config
- tmux config
- git config
- diff-so-fancy

## Requirements

- zsh
- [rcm](https://github.com/thoughtbot/rcm)
- [delta](https://github.com/dandavison/delta)

## Installation

1. `git clone git@github.com:inickt/dotfiles.git ~/.dotfiles --recursive`

1. `env RCRC=$HOME/.dotfiles/rcrc rcup`  
After the initial installation, you can run rcup without the one-time 
variable RCRC being set (rcup will symlink the repo's rcrc to ~/.rcrc 
for future runs of rcup).


## Useful (TODO cleanup)

- bat
- htop
- diff-so-fancy
- kermit

