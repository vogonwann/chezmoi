function sshmate
    if not test -f ~/.ssh/config
        echo "⚠️ ~/.ssh/config not found!"
        return
    end

    set hosts (grep "^Host " ~/.ssh/config | awk '{print $2}' | sort | uniq | fzf --prompt="🔐 Choose SSH host > ")
    if test -z "$hosts"
        echo "❌ Cancelled."
        return
    end

    set mode (printf "%s\n" \
        "🚀 Normal" \
        "🪟 New kitty tab" \
        "🧱 tmux split" \
        "🔇 Background (no output)" \
        "📡 mosh" \
        | fzf --prompt="🔧 Launch mode > ")

    switch $mode
        case "🚀 Normal"
            ssh $hosts

        case "🪟 New kitty tab"
            if test -n "$KITTY_LISTEN_ON"
                kitty @ launch --tab-title "$hosts" ssh $hosts
            else
                echo "⚠️ Kitty remote control not active!"
                echo "💡 Add this to your config.fish:"
                echo '    set -x KITTY_LISTEN_ON "unix:/tmp/kitty-socket"'
                echo "💡 And start Kitty with:"
                echo '    kitty --listen-on=unix:/tmp/kitty-socket'
            end

        case "🧱 tmux split"
            if set -q TMUX
                tmux split-window -h "ssh $hosts"
            else
                echo "⚠️ Not in tmux session!"
            end

        case "🔇 Background (no output)"
            ssh -f $hosts "sleep 60" >/dev/null 2>&1 &
            echo "🔌 SSH connection to $hosts launched in background."

        case "📡 mosh"
            if type -q mosh
                mosh $hosts
            else
                echo "⚠️ mosh not installed!"
            end

        case "*"
            echo "❌ Cancelled."
    end
end

