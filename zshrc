# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

powerline-daemon -q
export XDG_CONFIG_HOME=$HOME/.config
 . /usr/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh


autoload -U +X bashcompinit && bashcompinit
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=4'

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

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
alias weather="curl -s wttr.in/Palma | head -n 37 && curl -s wttr.in/Moon | head -n 24"
alias scl="$HOME/.config/screenlayout.sh"
alias shrug="echo '¯\_(ツ)_/¯'"
alias cat='bat -p'
function vim() { if [[ $@ == "/etc/hosts" ]]; then command sudo vim /etc/hosts; else command vim "$@"; fi }
function documentation() {
	vim "$HOME/dotfiles/doc/$1.md"
}
alias doc=documentation

##### SSH-AGENT
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent | head -n 2 > ~/.ssh/ssh-agent-pid
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh/ssh-agent-pid)"
fi

PATH="${PATH}:/bin"

##### STARTX
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]
then exec startx
fi

