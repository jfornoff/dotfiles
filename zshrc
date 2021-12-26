setopt +o nomatch
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="avit"
DISABLE_AUTO_TITLE="true"

plugins=(asdf docker-compose dotenv fasd git gitfast vi-mode zsh-autosuggestions kubectl fzf)

source $ZSH/oh-my-zsh.sh

# VI Mode
export KEYTIMEOUT=1

export EDITOR='nvim'
export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"

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

# Command shortcuts
alias pairsession-open='tmux -2 -S /tmp/pair new-session -t pair -s pair -d && chown $(whoami):pair /tmp/pair && pairsession-attach'
alias pairsession-attach='tmux -2 -S /tmp/pair attach -t pair'
alias pg-start='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg-stop='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log stop'

alias gcof='git branch | fzf | xargs -n1 git checkout'
alias vim='nvim'

if command -v bat &> /dev/null; then
  alias cat='bat'
fi

# https://remysharp.com/2018/08/23/cli-improved
alias preview="fzf --preview 'bat --color \"always\" {}'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.cargo/env ] && source ~/.cargo/env

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
