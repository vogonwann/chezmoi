function runanything
    set choice (printf "%s\n" \
        "🗂 Open file" \
        "📝 Edit file" \
        "🚀 Run script" \
        "💬 Run command" \
        "📁 cd into directory" \
        | fzf --prompt="Run Anything > " --height=50% --reverse)

    switch $choice
        case "🗂 Open file"
            set file (fd . --type f | fzf --prompt="🗂 Select file > ")
            if test -n "$file"
                xdg-open "$file" >/dev/null 2>&1
            end

        case "📝 Edit file"
            set file (fd . --type f | fzf --prompt="📝 Select file to edit > ")
            if test -n "$file"
                $EDITOR "$file"
            end

        case "🚀 Run script"
            set script (fd . --type f --exec bash -n {} \; 2>/dev/null | fzf --prompt="🚀 Select script > ")
            if test -n "$script"
                bash "$script"
            end

        case "💬 Run command"
            echo "💬 Enter shell command:"
            read cmd
            eval $cmd

        case "📁 cd into directory"
            set dir (fd . --type d | fzf --prompt="📁 Select directory > ")
            if test -n "$dir"
                cd "$dir"
                echo "📍 Changed directory to $dir"
            end

        case "*"
            echo "❌ Cancelled."
    end
end

