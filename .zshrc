# ~/.zshrc только обычных пользователей,
# не системных, в том числе не root.


### ВАЖНО! Для нормальной совместной работы над файлами нужен групповой umask
# TODO: эта настройка должна действовать на всех несистемных пользователей.
umask 0002


### Включение из /etc/zsh/newuser.zshrc.recommended
# Так как в разных дистрибутивах там разные настройки,
# скопировал сюда те, которые проверил лично
# Set up the prompt

autoload -Uz promptinit
promptinit
prompt walters

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


### Смена заголовка терминала
# Перед каждым выводом PROMPT'а
precmd()
{
    [[ -t 1 ]] || return
    case "$TERM" in
        *xterm*|screen|rxvt|(dt|k|E)term*)
            print -Pn "\e]2; [$HOST %~]\a"
        ;;
    esac
}

# После ввода команды, перед ее запуском
# Если запускается screen, нужно успеть поставить в заголовок
# имя хоста без мусора, т.к. потом будет меняться строка внутри screen-а.
preexec() {
    [[ -t 1 ]] || return
    case "$TERM" in
        *xterm*|screen|rxvt|(dt|k|E)term*)
            if [[ "$1" =~ "screen *.*" ]]; then
                #print -Pn "\e]2; $HOST\a"
                print -Pn "\e]2; ${FQDN:-$HOST}\a"
            else
                print -Pn "\e]2; [$HOST %~] $1\a"
            fi
        ;;
    esac
}

# Для заголовка терминала, в котором сидит screen,
# мне сейчас удобнее использовать полное имя компа.
export FQDN="`hostname --fqdn`"


### Переопределим приглашение, стандартные схемы ужасны

# nice green prompt (EMMS)
#PROMPT=$'%{\e[1;32m%}[%m:%{\e[1;34m%}%~%{\e[1;32m%}] %{\e[1;31m%}%#%{\e[0m%} '
#RPROMPT=$'%{\e[1;32m%}[%{\e[1;33m%}%T%{\e[1;32m%}]%{\e[0m%}'

# Часы справа портят копипаст с консоли, надоело,
# поэтому у меня они теперь слева.
# Ярко:
#PROMPT=$'%{\e[1;32m%}[%{\e[1;33m%}%D{%H:%M}%{\e[1;32m%}]%{\e[0m%} %{\e[1;32m%}[%m %{\e[1;34m%}%~%{\e[1;32m%}] %{\e[1;31m%}%#%{\e[0m%} '
# Тускло:
#PROMPT=$'%{\e[32m%}[%{\e[33m%}%D{%H:%M}%{\e[32m%}]%{\e[0m%} %{\e[32m%}[%m %{\e[34m%}%~%{\e[32m%}] %{\e[31m%}%#%{\e[0m%} '
# Тускло, с ярким pwd:
PROMPT=$'%{\e[32m%}[%{\e[33m%}%D{%H:%M}%{\e[32m%}]%{\e[0m%} %{\e[32m%}[%m %{\e[1;34m%}%~%{\e[0;32m%}] %{\e[31m%}%#%{\e[0m%} '
# На всякий случай сотрем, если от прошлого запуска что-нибудь осталось
RPROMPT=$''


### Строка приглашения mysql - [time] host:db>_
export MYSQL_PS1='[\R:\m]\ \h:\d>\_'


### Полезные алиасы для ls
# формат даты всегда ISO
alias ls='ls -F --color=auto --time-style=long-iso'
alias ll='ls -l'
alias la='ls -A'
alias li='ls -ial'
alias l='ls -al'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'


### Синтаксическая подсветка диффов в subversion
if test -x "`which colordiff`"; then
    alias svn-diff='svn diff --diff-cmd colordiff'
else
    alias svn-diff='svn diff'
fi


### Прочие алиасы
alias sauu='sudo apt-get update; sudo apt-get upgrade'
alias cd..='cd ..'
