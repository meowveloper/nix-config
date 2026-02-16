#!/usr/bin/env bash

# Set directory and resolve to absolute path (handles symlinks)
wall_dir=$(readlink -f "$HOME/.config/wallpapers")

# Check if directory exists
if [ ! -d "$wall_dir" ]; then
    echo "Wallpaper directory not found: $wall_dir"
    exit 1
fi

# Get list of files and format for Rofi with icons
# Format: display_name\0icon\x1ffull_path
list_wallpapers() {
    find "$wall_dir" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort | while read -r file; do
        filename=$(basename "$file")
        echo -en "$filename\0icon\x1f$file\n"
    done
}

# Run Rofi
selected=$(list_wallpapers | rofi -dmenu -i -show-icons -p "Select Wallpaper" -theme "$HOME/.config/rofi/wallpaper.rasi")

# If selected
if [ -n "$selected" ]; then
    full_path="$wall_dir/$selected"
    
    if [ -f "$full_path" ]; then
        # Call the existing wallpaper script
        ~/.config/matugen/wallpaper.sh "$full_path"
        
        # Notify user
        notify-send "Wallpaper Changed" "$selected" -i "$full_path"
    else
        echo "Error: File not found - $full_path"
    fi
fi
