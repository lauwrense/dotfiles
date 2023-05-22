if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings
set -gx EDITOR nvim

# Remove underlines
set fish_color_valid_path

starship init fish | source
zoxide init fish | source

fish_config theme choose nordfox

abbr -a ls exa -la --icons --git -s type
abbr -a ll exa -la --icons --git --ignore-glob .git -s type -T

z ~
