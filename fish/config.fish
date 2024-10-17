
if status is-interactive
    if test -n "$NVIM"
        set -g fish_key_bindings fish_default_key_bindings
    else
        fish_vi_key_bindings
    end

    bind --erase -a


    if test -z "$NVIM"; and test -z "$TMUX"
        cd ~;
    end
end

set os (uname)
set fish_color_valid_path
set -g fish_autosuggestion_enabled 0

abbr -a ls eza -la --icons --git -s type
abbr -a ll eza -la --icons --git --git-ignore -s type -T

zoxide init fish | source
starship init fish | source
fzf --fish | source

fish_config theme choose Catppuccin\ Frappe

# Theme
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
--color=selected-bg:#51576d \
--multi"
