#!/usr/bin/env bash

# Toggle wlsunset nightlight
if pgrep -x "wlsunset" > /dev/null; then
    pkill -x "wlsunset"
else
    # Start wlsunset with a fixed temperature (3000K)
    # Using neutral coordinates to avoid location-based calculation
    wlsunset -T 6500 -t 3000 -l 0 -L 0 &
fi
