function gitmenu
    set choice (printf "%s\n" \
        "🔍 Status" \
        "➕ Add all" \
        "📝 Commit" \
        "🧙 Commit (cz)" \
        "📥 Pull" \
        "📤 Push" \
        "💾 Stash" \
        "🔁 Stash Pop" \
        "🏷️ Create Tag" \
        "🚀 Push Tag" \
        "🌿 Checkout Branch" \
        "🌱 Create Branch" \
        "📜 Log" \
        "🧾 Diff file" \
        "🧠 Interactive Rebase" \
        "🦾 Open lazygit" \
        | fzf --prompt="Git Menu > " --height=50% --reverse)

    switch $choice
        case "🔍 Status"
            git status

        case "➕ Add all"
            git add .
            echo "✅ All changes staged."

        case "📝 Commit"
            echo "📝 Enter commit message:"
            read msg
            git commit -am "$msg"

        case "🧙 Commit (cz)"
            if type -q cz
                cz commit
            else
                echo "⚠️ 'cz' (commitizen) not installed!"
            end

        case "📥 Pull"
            git pull

        case "📤 Push"
            git push

        case "💾 Stash"
            git stash
            echo "💾 Changes stashed."

        case "🔁 Stash Pop"
            git stash pop

        case "🏷️ Create Tag"
            echo "🏷️ Enter tag name:"
            read tag
            git tag $tag
            echo "✅ Tag '$tag' created."

        case "🚀 Push Tag"
            echo "🚀 Enter tag name to push:"
            read tag
            git push origin $tag
            echo "🚀 Tag '$tag' pushed."

        case "🌿 Checkout Branch"
            set branch (git branch --all | grep -v HEAD | sed 's/.* //' | fzf --prompt="🌿 Select branch > ")
            if test -n "$branch"
                git checkout $branch
            end

        case "🌱 Create Branch"
            echo "🌱 Enter new branch name:"
            read new_branch
            git checkout -b $new_branch

        case "📜 Log"
            git log --oneline --graph --decorate --all | less

        case "🧾 Diff file"
            set file (git diff --name-only | fzf --prompt="🧾 Select file > ")
            if test -n "$file"
                git diff $file | less
            else
                echo "❌ No file selected."
            end

        case "🧠 Interactive Rebase"
            echo "🧠 Enter base commit (e.g. HEAD~3):"
            read base
            if test -n "$base"
                git rebase -i $base
            else
                echo "❌ No commit entered."
            end

        case "🦾 Open lazygit"
            if type -q lazygit
                lazygit
            else
                echo "⚠️ 'lazygit' is not installed!"
            end

        case "*"
            echo "❌ Cancelled. Launching lazygit as fallback..."
            if type -q lazygit
                lazygit
            else
                echo "⚠️ 'lazygit' not found!"
            end
    end
end

