#!/bin/bash

grim -g "$(slurp)" $HOME/Pictures/Screenshots/$(date +'%s_grim.png')

play $HOME/.config/sway/assets/sounds/camera-shutter.ogg
