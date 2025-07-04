#!/usr/bin/env bash
# English: Print current keyboard layout using niri msg --json keyboard-layouts

layout=$(niri msg --json keyboard-layouts | jq -r '.names[.current_idx]')

# Map to short names if you want
case "$layout" in
    "English (US)")      echo "US" ;;
    "Serbian (Latin)")   echo "RS-Lat" ;;
    "Serbian")           echo "RS-Cyr" ;;
    *)                   echo "$layout" ;;
esac
