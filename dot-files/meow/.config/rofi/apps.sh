#!/usr/bin/env bash


dir="$HOME/.config/rofi"
theme='style-9'

## Run
rofi \
    -show drun \
    -theme "${dir}"/"${theme}".rasi
