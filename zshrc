set -k
# Run "zinit module build" first
module_path+=( "/home/davide/.zinit/bin/zmodules/Src" )
zmodload zdharma/zplugin

# oh-my-zsh
ZSH=/usr/share/oh-my-zsh/
DISABLE_AUTO_UPDATE="true"
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source ~/.zinit/bin/zinit.zsh
zinit snippet 'https://github.com/robbyrussell/oh-my-zsh/raw/master/plugins/git/git.plugin.zsh'

# Set prompt while theme loads
autoload -U colors && colors
PS1="%{$fg[black]%}%{$bg[blue]%} ~ %{$reset_color%}%{$fg[blue]%}%{$reset_color%}%  "

# Load plugins in the background
zinit wait lucid for \
    zsh-users/zsh-autosuggestions \
    romkatv/powerlevel10k \
    wfxr/forgit \
    OMZ::plugins/fzf/fzf.plugin.zsh \
    OMZ::plugins/taskwarrior/taskwarrior.plugin.zsh \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting

export EDITOR='vim'
XDG_CONFIG_HOME=${HOME}/.config

# Set terminal window title to current dir
precmd () {print -Pn "\e]0;${PWD/#$HOME/~}" }
preexec() {print -Pn "\e]0;[$1]\a"}

# Navigate autocompletion menu
zstyle ':completion:*' menu select
zmodload zsh/complist
# Case insensitive autocompletion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt no_list_ambiguous

# FZF
FZF_BASE=/usr/bin/fzf
FZF_COMPLETION_OPTS='--preview "bat --color always {}"'

# Powerline config
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_VCS_SHORTEN_LENGTH=16
POWERLEVEL9K_VCS_SHORTEN_MIN_LENGTH=16
POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_VCS_SHORTEN_DELIMITER=""
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(virtualenv kubecontext background_jobs)
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3

# Autocompletion fish style
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_all_dups
setopt HIST_IGNORE_SPACE

# CD History
setopt AUTO_PUSHD
setopt PUSHD_MINUS

autoload -U +X bashcompinit && bashcompinit
#autoload -U compinit && compinit
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Key bind
bindkey '^?'      backward-delete-char          # bs         delete one char backward
bindkey '^[[3~'   delete-char                   # delete     delete one char forward
bindkey '^[[H'    beginning-of-line             # home       go to the beginning of line
bindkey '^[[F'    end-of-line                   # end        go to the end of line
bindkey '^[[1;5C' forward-word                  # ctrl+right go forward one word
bindkey '^[[1;5D' backward-word                 # ctrl+left  go backward one word
bindkey '^H'      backward-kill-word            # ctrl+bs    delete previous word
bindkey '^[[3;5~' kill-word                     # ctrl+del   delete next word
bindkey '^J'      backward-kill-line            # ctrl+j     delete everything before cursor
bindkey '^[[D'    backward-char                 # left       move cursor one char backward
bindkey '^[[C'    forward-char                  # right      move cursor one char forward
bindkey '^[[A'    up-line-or-beginning-search   # up         prev command in history
bindkey '^[[B'    down-line-or-beginning-search # down       next command in history
bindkey -M menuselect '^[[Z' reverse-menu-complete # shift+tab menu navigation

# Aliases
alias weather="curl -s wttr.in/Granada | head -n 37 && curl -s wttr.in/Moon | head -n 24"
alias scl="$HOME/.config/screenlayout.sh"
alias shrug="echo '¯\_(ツ)_/¯'"
alias cat="bat -p --theme='Monokai Extended Light'"
alias k=kubectl
alias kns=kubens
alias xmind="PATH=\"/usr/lib/jvm/java-8-openjdk/jre/bin/:$PATH\" XMind"
alias ssh="env TERM=xterm-256color ssh"
function based() { echo "$1" | base64 -d && echo }


##### STARTX
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]
then exec startx
fi
