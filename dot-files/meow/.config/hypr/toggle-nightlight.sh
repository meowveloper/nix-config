#!/usr/bin/env bash

# Toggle nightlight
current_temp=$(hyprctl hyprsunset temperature)
if [ "$current_temp" -eq 3000 ]; then
    hyprctl hyprsunset temperature 6000  # Set to daytime temperature
else
    hyprctl hyprsunset temperature 3000   # Set to nightlight temperature
fi
