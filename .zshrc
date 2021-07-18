# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode z magic-enter proxy kubectl docker)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#Manually installed executables go into here
export PATH="$HOME/Programs/bin:$PATH"

function is_cygwin() {
  [[ "$(uname -s)" = CYGWIN* ]]
}
function is_mac() {
  [[ "$(uname -s)" = Darwin ]]
}
function has_cmd() {
  command -v $1 >/dev/null
}

if is_mac && has_cmd brew >/dev/null; then
  #brew install homeshick
  export HOMESHICK_DIR=/usr/local/opt/homeshick
  source "/usr/local/opt/homeshick/homeshick.sh"

  #brew install coreutils
  export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  # brew tap domt4/autoupdate
  export HOMEBREW_AUTO_UPDATE_SECS="86400"

  # brew install git-extras
  source "/usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh"
  if command -v gtar>/dev/null; then
    export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
  fi
fi

function is_raspberry_pi_os_64() {
  grep "Raspberry Pi" /proc/device-tree/model &> /dev/null && [ "aarch64" = $(uname -m) ]
}
function is_wsl() {
  grep microsoft /proc/sys/kernel/osrelease &> /dev/null
}
function is_intellij_terminal() {
  compgen -v | grep -e "^_INTELLIJ_.*" >/dev/null && [ $SHLVL = "1" ]
}

bindkey '\e.' insert-last-word
bindkey '≥' insert-last-word

if has_cmd dircolors; then
  eval $(dircolors ~/.dircolors.256dark)
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  alias ls='ls --color=auto'
fi

if has_cmd go; then
  GOPATH="$HOME/go"
  GOBIN="${GOPATH}/bin"
  if is_cygwin; then
    #Under cygwin, golang don't recognize unix path style
    GOPATH=$(cygpath -m ${GOPATH})
    GOBIN=$(cygpath -m ${GOBIN})
    #Cygwin need the unix path
    PATH="$(cygpath -u ${GOBIN}):$PATH"
  else
    PATH="${GOBIN}:$PATH"
  fi
  export GOPATH GOBIN
fi


# export TERM='xterm-256color'


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export DEFAULT_PROXY="127.0.0.1:8080"
if is_wsl; then
  # WSL Interface on Windows Host
  WINHOST=$(grep nameserver /etc/resolv.conf | awk '{print $2}')
  export DEFAULT_PROXY="$WINHOST:3128"
fi


# https://github.com/gdubw/gng
alias gradle='gng'

if ! is_cygwin; then
  #use yadm to backup system configuration under /etc
  if has_cmd yadm; then
    [ -d /backup/system ] || sudo mkdir -p /backup/system
    alias sysyadm="sudo yadm -Y /backup/system"
  fi
fi

#Intellij Idea Terminal
if is_intellij_terminal; then
  cd $OLDPWD
fi

if is_wsl; then
  #In WSL, Ingnore the kubectl provided by Docker Desktop
  alias kubectl='/usr/bin/kubectl'
fi
if has_cmd vim; then
  export EDITOR=vim
fi

if has_cmd broot; then
  [ -d $HOME/.config/broot ] && source $HOME/.config/broot/launcher/bash/br
fi
[ -d $HOME/.cargo/env ] && source $HOME/.cargo/env

LINUX_BREW="/home/linuxbrew/.linuxbrew/bin/brew"
if [ -x ${LINUX_BREW} ]; then
  eval "$($LINUX_BREW shellenv)"
fi
