[[ -c /dev/null ]]  ||  return
zmodload zsh/system ||  return

TRANSIENT_PROMPT="%F{blue}%~%f %(?.%F{green}.%F{red})❯%f "
TRANSIENT_EPROMPT=

preexec_prompt() {
    timer=$(($(date +%s%0N)/1000000))
}

preexec_functions+=(preexec_prompt)
precmd_functions+=(set_prompt)

function set_prompt {

    PROMPT="%F{blue}%~%f"

    if [ $timer ]; then
        local now=$(($(date +%s%0N)/1000000))
        local elapsed=$(($now-$timer))
        local total_sec=$(($elapsed / 1000))

        local milis=$(($elapsed % 1000))
        local seconds=$(($total_sec % 60))
        local minutes=$((($total_sec / 60) % 60))
        local hours=$(($total_sec / 3600))

        RPROMPT="[%F{yellow}%B"

        if (( $elapsed > 1000 )); then
            if (($hours > 0)); then RPROMPT+=${hours}h fi
            if (($minutes > 0)); then RPROMPT+=${minutes}m fi
            if (($seconds > 0)); then RPROMPT+=${seconds}s fi
        else
            RPROMPT+="${elapsed}ms"
        fi

        RPROMPT+="%b%f]"
    else
        RPROMPT=""
    fi

    # Git Integration
    if git rev-parse --is-inside-work-tree &> /dev/null ; then
        local head=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
        PROMPT+=" %F{magenta}${head}%f"
    fi

    PROMPT+=" %(?.%F{green}.%F{red})❯%f "
}

zle -N send-break _prompt_widget-send-break
function _prompt_widget-send-break {
    _prompt_widget-zle-line-finish
    zle .send-break
}

zle -N zle-line-finish _prompt_widget-zle-line-finish
function _prompt_widget-zle-line-finish {
    TRANSIENT_RPROMPT=$RPROMPT
    (( ! _prompt_fd )) && {
        sysopen -r -o cloexec -u _prompt_fd /dev/null
        zle -F $_prompt_fd _prompt_restore_prompt
    }
    zle && PROMPT=$TRANSIENT_PROMPT RPROMPT=$TRANSIENT_RPROMPT && zle -R
}

function _prompt_restore_prompt {
    exec {1}>&-
    (( ${+1} )) && zle -F $1
    _prompt_fd=0

    set_prompt

    unset timer

    zle reset-prompt
    zle -R
}

(( ${+precmd_functions} )) || typeset -ga precmd_functions
(( ${#precmd_functions} )) || {
    do_nothing {true}
    precmd_functions=(do_nothing)
}

precmd_functions+=_prompt_precmd
function _prompt_precmd {
    TRAPINT() { zle && _prompt_widget-zle-line-finish; return $(( 128 + $1 )) }
}
