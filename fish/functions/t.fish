function t -d "tmux into a new or existing session"
    argparse --min-arg=1 "n/name=" -- $argv
    or return

    if test $argv[1] = "."
        set argv[1] (pwd)
    end

    set -f _pwd (pwd)
    set -f name ""
    set -f z_query ""


    # check if current argv is in zoxide database
    if zoxide query $argv &> /dev/null
        set -f z_query "$(zoxide query $argv 2> /dev/null)"
    else if test -d $argv
        set -f z_query $argv
    end

    # check naming
    if set -ql _flag_name;
        set -f name $_flag_name
    else
        set -f name "$(string match -r '[^\/\\\\\n]+$' $z_query)"
        set -f name "$(string match -r '^[^\\.]*' $name)"
    end

    if test -n "$TMUX"
        and test "$(tmux display-message -p '#S')" = "$name"
        if test "$_pwd" != "$z_query"
            cd $z_query
        end
        return
    end

    if test -n "$NVIM"
        and test -z "$TMUX"
        echo "not allowed to be in nvim while not being in tmux"
        return
    end


    cd $z_query

    if not git rev-parse -q --is-inside-work-tree &> /dev/null
        echo "$z_query not a git directory"
        cd $_pwd
        return
    end

    cd $_pwd


    if test "$(ps -e | rg -q tmux | count)" -le 0
        and not tmux has -t $name &> /dev/null
        tmux new -d -c $z_query -s $name
    end

    if test -z "$TMUX"
        tmux attach -t $name
    else
        tmux switchc -t $name
    end
end
