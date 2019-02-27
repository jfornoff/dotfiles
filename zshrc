setopt +o nomatch
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="avit"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(asdf docker-compose dotenv git vi-mode ubuntu zsh-autosuggestions kubectl z)

source $ZSH/oh-my-zsh.sh

# VI Mode
export KEYTIMEOUT=1
bindkey '^r' history-incremental-search-backward

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'

function dockercleanimages {
  docker rmi -f $(docker images -q -f dangling=true)
}

function dockercleancontainers {
  docker rm $(docker ps -a -q)
}

export PATH="$PATH:$HOME/bin:$HOME/go/bin"

# Source secrets files
for f in ~/.secrets/*; do
  test -f "$f" || continue
  source $f
done

# Source additional shell configs
for f in ~/.conf.rc/*; do
  test -f "$f" || continue
  source $f
done

alias pairsession-open='tmux -2 -S /tmp/pair new-session -t pair -s pair -d && chown $(whoami):pair /tmp/pair && pairsession-attach'
alias pairsession-attach='tmux -2 -S /tmp/pair attach -t pair'
alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg-stop='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop'

alias gcof='git branch -a | fzf | xargs -n1 git checkout'
alias vim='nvim'

if command -v bat &> /dev/null; then
  alias cat='bat'
fi

# https://remysharp.com/2018/08/23/cli-improved
alias preview="fzf --preview 'bat --color \"always\" {}'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jfornoff/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/jfornoff/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jfornoff/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/jfornoff/google-cloud-sdk/completion.zsh.inc'; fi
