#zmodload zsh/zprof
export XDG_CONFIG_HOME=$HOME/.config

# oh-my-zsh
ZSH=/usr/share/oh-my-zsh/
DISABLE_AUTO_UPDATE="true"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/zsh_plugins.sh

plugins=(fzf kubectl)
source /usr/share/fzf/key-bindings.zsh
#source /usr/share/fzf/completion.zsh

# FZF
export FZF_BASE=/usr/bin/fzf
export FZF_COMPLETION_OPTS='--preview "bat --color always {}"'


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

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_ignore_all_dups

# Autocompletion fish style
ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'
#autoload -U +X bashcompinit && bashcompinit
#autoload -U up-line-or-beginning-search
#autoload -U down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey "^[[A" up-line-or-beginning-search # Up
#bindkey "^[[B" down-line-or-beginning-search # Down

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Aliases
alias weather="curl -s wttr.in/Granada | head -n 37 && curl -s wttr.in/Moon | head -n 24"
alias scl="$HOME/.config/screenlayout.sh"
alias shrug="echo '¯\_(ツ)_/¯'"
alias cat="bat -p --theme='Monokai Extended Light'"
alias subl=subl3
alias k=kubectl
alias xmind="PATH=\"/usr/lib/jvm/java-8-openjdk/jre/bin/:$PATH\" XMind"

##### SSH-AGENT
#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#    ssh-agent | head -n 2 > ~/.ssh/ssh-agent-pid
#fi
#if [[ "$SSH_AGENT_PID" == "" ]]; then
#    eval "$(<~/.ssh/ssh-agent-pid)"
#fi

##### STARTX
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]
then exec startx
fi


#zprof
