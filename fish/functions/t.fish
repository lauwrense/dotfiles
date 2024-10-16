function t -d "tmux into a new or existing session"
    argparse --min-arg=1 "n/name=" -- $argv
    or return

    if test $argv[1] = "."
        set argv[1] (pwd)
    end

    set -f name ""
    set -f z_query "$(zoxide query $argv)"

    if set -ql _flag_name;
        set -f name $_flag_name
    else
        set -f name "$(string match -r '[^\/\\\\\n]+$' $z_query)"
        set -f name "$(string match -r '^[^\\.]*' $name)"
    end


    if test -n "$NVIM"
        and test -z "$TMUX"
        echo "not allowed to be in nvim while not being in tmux"
        return
    end

    set -f _pwd (pwd)
    cd $z_query

    if not git rev-parse -q --is-inside-work-tree &> /dev/null
        echo "$z_query not a git directory"
        cd $_pwd
        return
    end

    cd $_pwd


    if test "$(ps -e | rg -q tmux | count)" -le 0
        and test -z "$(tmux has -t $name)"
        tmux new -d -c $z_query -s $name
    end

    if test -z "$TMUX"
        tmux attach -t $name
    else
        tmux switchc -t $name
    end
end
