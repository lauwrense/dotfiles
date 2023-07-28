if status is-interactive
    # Commands to run in interactive sessions can go here
end

set os (uname)

if test $os != "Nvim"
    fish_vi_key_bindings
end

set -gx EDITOR nvim
set -g fish_autosuggestion_enabled 0

# Remove underlines
set fish_color_valid_path

starship init fish | source
zoxide init fish | source

fish_config theme choose nordfox

abbr -a ls exa -la --icons --git -s type
abbr -a ll exa -la --icons --git --ignore-glob .git -s type -T
abbr -a v nvim

bind --erase -a 
z ~
