# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias tclsh='tclsh9.0'

alias python='/usr/local/bin/python3'
alias pip='/usr/local/bin/pip3'

alias truestudio='cd  $HOME/truestudio/ide && ./TrueSTUDIO'

if [[ $GOPATH != *"$HOME/src/go"* ]];then
    export GOPATH=$HOME/src/go
fi

if [[ $PATH != *"$GOPATH/bin"* ]];then
    export PATH=$PATH:$GOPATH/bin
fi

if [[ $PATH != *"$HOME/home_local/texlive/2018/bin/x86_64-linux"* ]];then
    export PATH=$PATH:$HOME/home_local/texlive/2018/bin/x86_64-linux
fi

if [[ $MANPATH == "" ]];then
    MANPATH="$HOME/home_local/texlive/2018/texmf-dist/doc/man"; export MANPATH
fi

if [[ $MANPATH != *"$HOME/home_local/texlive/2018/texmf-dist/doc/man"* ]];then
    export MANPATH=$MANPATH:$HOME/home_local/texlive/2018/texmf-dist/doc/man
fi

if [[ $INFOPATH == "" ]];then
    INFOPATH="$HOME/home_local/texlive/2018/texmf-dist/doc/info"; export INFOPATH
fi

if [[ $INFOPATH != *"$HOME/home_local/texlive/2018/texmf-dist/doc/info"* ]];then
    export INFOPATH=$INFOPATH:$HOME/home_local/texlive/2018/texmf-dist/doc/info
fi

source ~/.zplug/init.zsh
zplug "Tarrasch/zsh-bd"
zplug "sinetoami/web-search"
zplug "zdharma/fast-syntax-highlighting"
zplug load --verbose



PATH="/home/lizhao/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/lizhao/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lizhao/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lizhao/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lizhao/perl5"; export PERL_MM_OPT;

alias ana='bash $HOME/home_local/scripts/ana.sh'
alias anarun='ana && $HOME/anaconda3/bin/anaconda-navigator'

