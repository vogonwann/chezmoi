#!/usr/bin/env bash

# English: Custom Niri workspace indicator for Waybar

out=""
json=$(niri msg --json workspaces)
active=$(echo "$json" | jq '.current_idx')
names=$(echo "$json" | jq -r '.names[]')
i=0
for ws in $names; do
    if [ $i -eq $active ]; then
        # Active workspace - mark/bold it
        out="$out [<b>$ws</b>]"
    else
        out="$out [$ws]"
    fi
    i=$((i+1))
done

# Output as text and JSON for waybar
echo "{\"text\": \"$out\", \"tooltip\": \"Switch workspace\", \"class\": \"niri-workspaces\"}"
