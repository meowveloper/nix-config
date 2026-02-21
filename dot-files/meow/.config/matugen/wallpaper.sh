#!/usr/bin/env bash
WALL="$1"


if [[ -f ~/.cache/last-wallpaper ]]; then
    rm ~/.cache/last-wallpaper
fi
cp "$WALL" ~/.cache/last-wallpaper

matugen image "$WALL"
