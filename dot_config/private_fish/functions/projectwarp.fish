function projectwarp
    set projects_dir ~/Development

    if not test -d $projects_dir
        echo "❌ Directory $projects_dir does not exist!"
        return
    end

    # тражи пројекте дубине 2
    set project (fd --type d --max-depth 2 --min-depth 2 . $projects_dir | fzf --prompt="🚀 Pick project > ")
    if test -z "$project"
        echo "❌ Cancelled."
        return
    end

    set action (printf "%s\n" \
        "📂 cd into project" \
        "📝 open in nvim" \
        "🧪 run git status" \
        "🪟 open in new kitty tab" \
        | fzf --prompt="⚙️ What to do with $project > ")

    switch $action
        case "📂 cd into project"
            cd "$project"
            echo "📍 Now in $project"

        case "📝 open in nvim"
            nvim "$project"

        case "🧪 run git status"
            git -C "$project" status

        case "🪟 open in new kitty tab"
            if test -n "$KITTY_LISTEN_ON"
                kitty @ launch --tab-title (basename "$project") --cwd "$project"
            else
                echo "⚠️ Kitty remote control not active!"
                echo '💡 Start Kitty with: kitty --listen-on=unix:/tmp/kitty-socket'
            end

        case "*"
            echo "❌ Cancelled."
    end
end

