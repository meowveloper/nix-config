#!/usr/bin/env bash


dir="$HOME/.config/rofi"
theme='apps'

## Run
rofi \
    -show drun \
    -theme "${dir}"/"${theme}".rasi
