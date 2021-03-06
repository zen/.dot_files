# Zsh-specific profile. For Bash specific look at profile,
# for common variables look at profile_common.
#
setopt allexport

if [ -e ~/.pscolors ]; then
  source ~/.pscolors
fi
PS1="%{$PS_USERCOLOR%}%n%{$PS_ATCOLOR%}@%{$PS_HOSTCOLOR%}%M%{$PS_COLONCOLOR%}:%{$PS_PATHCOLOR%}%~%{$PS_PROMPTCOLOR%} $ %{$PS_NOCOLOR%}"
#RPROMPT="%D{%T}"
HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
HISTIGNORE="&:ls:[bf]g:exit:reset:clear:cd:cd ..:cd.."
setopt INC_APPEND_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE \
  HIST_REDUCE_BLANKS HIST_SAVE_NO_DUPS HIST_VERIFY EXTENDED_HISTORY 
unsetopt share_history

setopt alwaystoend autocontinue autolist autoresume autopushd \
  clobber combiningchars correct listrowsfirst longlistjobs mailwarning \
  nomatch notify pushdtohome menucomplete extendedhistory
unsetopt autocd bgnice beep

# unsetopt autoparamslash

bindkey -e

#preexec() {
#    print -rn -- $terminfo[cuu1]
#    let cols=$terminfo[cols]-9
#    while [[ $cols -gt 0 ]]; do
#        print -n $terminfo[cuf1]
#        let cols=cols-1
#    done
#    print `date +%H:%M:%S`
#}

autoload -Uz compinit
compinit

bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[7~' beginning-of-line
bindkey '\e[8~' end-of-line
bindkey '^F' forward-word
bindkey '^B' backward-word
bindkey '\e[1;5C' forward-word
bindkey '\e[1;5D' backward-word
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey '\e[3~' delete-char

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zcache
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt \
  '%SAt %p: Hit TAB for more, or the character to insert%s'
#zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle ':completion:*' menu select=long-list select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
  'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt \
  '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:processes' command 'ps -axw'
zstyle ':completion:*:processes-names' command 'ps -awxho command'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
  'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*:expand:*' tag-order all-expansions
# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
# match uppercase from lowercase
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:scp:*' tag-order \
  files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
  files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
  users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
  hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

source ~/.profile_common

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
