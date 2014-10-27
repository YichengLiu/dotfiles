# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"
#ZSH_THEME="af-magic"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-flow autojump history-substring-search mvn brew)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/sbin:$PATH
export PATH=/Users/gods/Programs/casperjs/bin:$PATH
export PATH=/Applications/TextMate.app/Contents/Resources/:$PATH
export GOPATH=$HOME/Go
export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/Programs/android-sdk/platform-tools:$PATH

# alias ls='ls --color=auto'
alias ll='ls -la'
alias gnome='sudo systemctl start gdm.service'
alias sc='sudo systemctl'
alias q='cd ..'
alias vim='mvim -v'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
alias te='trs'
alias tc='trs {=zh}'

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
