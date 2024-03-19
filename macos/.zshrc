# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh autocomplete: https://github.com/marlonrichert/zsh-autocomplete#manually
#source ~/manualinstall/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# for gpg key: https://unix.stackexchange.com/a/608921
export GPG_TTY=$TTY

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Upgrade bash https://stackoverflow.com/a/76164898/12555857
export PATH="/opt/homebrew/bin:$PATH"

# For krew
export PATH="${PATH}:${HOME}/.krew/bin"

# For cargo
export PATH="/Users/rahkochar/.cargo/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Move word forward or backward
# https://stackoverflow.com/a/70703825/12555857
bindkey '^f' forward-word
bindkey '^b' backward-word

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

## Options section
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.
setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
setopt histignorespace                                          # Don't save commands that start with space

zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

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
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Use syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use history substring search
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh


# Offer to install missing package if command is not found
if [[ -r /usr/share/zsh/functions/command-not-found.zsh ]]; then
    source /usr/share/zsh/functions/command-not-found.zsh
    export PKGFILE_PROMPT_INSTALL_MISSING=1
fi

# Set terminal window and tab/icon title
#
# usage: title short_tab_title [long_window_title]
#
# See: http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
# Fully supports screen and probably most modern xterm and rxvt
# (In screen, only short_tab_title is used)
function title {
  emulate -L zsh
  setopt prompt_subst

  [[ "$EMACS" == *term* ]] && return

  # if $2 is unset use $1 as default
  # if it is set and empty, leave it as is
  : ${2=$1}

  case "$TERM" in
    xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty|st*)
      print -Pn "\e]2;${2:q}\a" # set window name
      print -Pn "\e]1;${1:q}\a" # set tab name
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\" # set screen hardstatus
      ;;
    *)
    # Try to use terminfo to set the title
    # If the feature is available set title
    if [[ -n "$terminfo[fsl]" ]] && [[ -n "$terminfo[tsl]" ]]; then
      echoti tsl
      print -Pn "$1"
      echoti fsl
    fi
      ;;
  esac
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m:%~"

# Runs before showing the prompt
function mzc_termsupport_precmd {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return
  title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

# Runs before executing the command
function mzc_termsupport_preexec {
  [[ "${DISABLE_AUTO_TITLE:-}" == true ]] && return

  emulate -L zsh

  # split command into array of arguments
  local -a cmdargs
  cmdargs=("${(z)2}")
  # if running fg, extract the command from the job description
  if [[ "${cmdargs[1]}" = fg ]]; then
    # get the job id from the first argument passed to the fg command
    local job_id jobspec="${cmdargs[2]#%}"
    # logic based on jobs arguments:
    # http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
    # https://www.zsh.org/mla/users/2007/msg00704.html
    case "$jobspec" in
      <->) # %number argument:
        # use the same <number> passed as an argument
        job_id=${jobspec} ;;
      ""|%|+) # empty, %% or %+ argument:
        # use the current job, which appears with a + in $jobstates:
        # suspended:+:5071=suspended (tty output)
        job_id=${(k)jobstates[(r)*:+:*]} ;;
      -) # %- argument:
        # use the previous job, which appears with a - in $jobstates:
        # suspended:-:6493=suspended (signal)
        job_id=${(k)jobstates[(r)*:-:*]} ;;
      [?]*) # %?string argument:
        # use $jobtexts to match for a job whose command *contains* <string>
        job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
      *) # %string argument:
        # use $jobtexts to match for a job whose command *starts with* <string>
        job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
    esac

    # override preexec function arguments with job command
    if [[ -n "${jobtexts[$job_id]}" ]]; then
      1="${jobtexts[$job_id]}"
      2="${jobtexts[$job_id]}"
    fi
  fi

  # cmd name only, or if this is sudo or ssh, the next cmd
  local CMD=${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}
  local LINE="${2:gs/%/%%}"

  title '$CMD' '%100>...>$LINE%<<'
}

autoload -U add-zsh-hook
add-zsh-hook precmd mzc_termsupport_precmd
add-zsh-hook preexec mzc_termsupport_preexec


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

export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

######################################################################

## Alias section
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB

alias gitgud='git reset --hard'
alias gitnotgud='sudo git reset --hard HEAD@{1}'
alias gba="git branch -a"
alias gcb="git checkout -b "
alias gc-="git checkout -"

function gcm() {
    git remote show "${1:-origin}" | sed -n '/HEAD branch/s/.*: //p' | xargs git checkout
}

# zsh
alias zshrc='vim ~/.zshrc'
alias sourcezshrc='source ~/.zshrc'

# kitty
alias kittyrc='vim ~/.config/kitty/kitty.conf'

# vim
alias vimrc='vim ~/.vimrc'

# Theming section  
autoload -U compinit colors zcalc
compinit -d
colors

export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

# Disable aws-cli pager https://stackoverflow.com/a/65163604/12555857
export AWS_PAGER=""

# Color man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# bat
# https://github.com/sharkdp/bat
export BATDIFF_USE_DELTA=true
alias cat='bat'

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}


# exa
# https://github.com/ogham/exa
alias ls="exa --icons"
alias lsl="exa --icons --long --git -F --oneline --time-style=long-iso --group-directories-first"
alias lsal="exa --icons --all --long --git -F --time-style=long-iso --group-directories-first"
alias tree="exa --tree --icons"

# dig https://github.com/mr-karan/doggo
alias dig="doggo "
# Pulumi
alias pu="pulumi up "
alias puc="pulumi up && confetty"
alias pd="pulumi destroy "
alias pd="pulumi destroy && confetty fireworks"
export PULUMI_CONFIG_PASSPHRASE=""

# Terraform
alias tf="terraform "
alias tfp="terraform plan "
alias tfa="terraform apply "

# Terragrunt
alias tg="terragrunt "
alias tgp="terragrunt plan && confetty"
alias tga="terragrunt apply && confetty fireworks"
DISABLE_TELEMETRY=true

# Kubernetes
# kubectl
alias kg="kubectl get "
alias kgpo="kubectl get pods "
alias kgns="kubectl get namespaces "
alias kgsvc="kubectl get services "
alias kgpvc="kubectl get pvc "
alias kgpv="kubectl get pv "
alias kgd="kubectl get deployments "
alias kgrs="kubectl get rs "
alias kgcf="kubectl get configmap "
alias kgall="kubectl get all "

alias kgallns="kubectl get all --all-namespaces"
alias nsall="--all-namespaces"

alias kcgc="kubectl config get-contexts"
alias kcuse="kubectl config use-context"

alias kaf="kubectl apply -f"
alias kdf="kubectl delete -f"

# Copilot https://github.com/github/gh-copilot
alias ghc="gh copilot "

# AWS # https://gist.github.com/sobi3ch/77892a6f6803968d64c6537b3c76ca22
alias aws.whoami="aws iam get-user --query User.Arn --output text"

AWS_CLI_AUTO_PROMPT="on-partial"

# Azure
alias az.whoami="az ad signed-in-user show --query userPrincipalName --output tsv"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rahkochar/manualinstall/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rahkochar/manualinstall/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rahkochar/manualinstall/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rahkochar/manualinstall/google-cloud-sdk/completion.zsh.inc'; fi

function kubectlgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    
    if [ -z "$1" ]
    then
        kubectl get --ignore-not-found ${i}
    else
        kubectl -n ${1} get --ignore-not-found ${i}
    fi
  done
}


function pidkill {
  kill -9 $(lsof -t -i:$1)
}

alias parrot="curl parrot.live"

alias music="termusic"
#alias termusic="cd ~/Music && termusic ."

alias resetcalendar="rm -rf ~/.cache/calendar.vim/google/access_token"

alias myip="dig +short txt ch whoami.cloudflare @1.0.0.1"

#################################################
#export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
#export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# MySql
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
# For compilers to find mysql@5.7 you may need to set:
# export LDFLAGS="-L/opt/homebrew/opt/mysql@5.7/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/mysql@5.7/include"
# For pkg-config to find mysql@5.7 you may need to set:
# export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql@5.7/lib/pkgconfig"
# Or, if you don't want/need a background service you can just run:
# /opt/homebrew/opt/mysql@5.7/bin/mysqld_safe --datadir=/opt/homebrew/var/mysql

# Add coursier to PATH
export PATH="$PATH:/Users/rahkochar/Library/Application Support/Coursier/bin"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$PATH:$(which python3)"
export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"

# https://stackoverflow.com/a/21012349/12555857
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
