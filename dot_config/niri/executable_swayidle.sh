#!/bin/sh 
swayidle -w timeout 600 'swaylock' timeout 900 'niri msg action power-off-monitors' before-sleep 'swaylock'


