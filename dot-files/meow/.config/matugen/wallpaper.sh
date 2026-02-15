#!/usr/bin/env bash
WALL="$1"

rm ~/.cache/last-wallpaper
cp "$WALL" ~/.cache/last-wallpaper

matugen image "$WALL"
