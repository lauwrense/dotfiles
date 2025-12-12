#! /bin/zsh

# ZINIT

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

zinit light catppuccin/zsh-syntax-highlighting
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

## Fzf integrations
zinit ice lucid wait
zinit snippet OMZP::fzf

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

zinit cdreplay -q

# COLORS

(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_HIGHLIGHT_STYLES[precommand]="fg=green"

export FZF_DEFAULT_OPTS=" \
    --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
    --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
    --color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
    --color=selected-bg:#51576d \
    --multi"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export LS_COLORS=`vivid generate catppuccin-frappe`

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# HISTORY

HISTFILE=~/.cache/zsh/histfile
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# BINDINGS

bindkey -M menuselect '^[[Z' reverse-menu-complete

# PROMPT

if [ -n "$DOTFILES" ]; then 
    source $DOTFILES/zsh/prompt.zsh
else
    source $HOME/dotfiles/zsh/prompt.zsh
fi

# ALIASES

alias ls="eza -la --icons --git -s type --git-ignore"
alias lsni="eza -la --icons --git -s type"
alias ll="eza -Tla --icons --git -s type --git-ignore"
alias llni="eza -Tla --icons --git -s type"
alias fzn="fzf --multi --bind 'enter:become(nvim {+})'"

# INTEGRATIONS

export PATH=$HOME/.local/bin:$PATH
export MANPATH=$HOME/.local/share/man:$MANPATH

if type "zoxide" &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

if type "opam" &> /dev/null; then
    eval "$(opam env --switch=default)"
fi

