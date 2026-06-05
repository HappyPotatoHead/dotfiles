#!/usr/bin/env bash

ROFI_THEME="~/.config/rofi/clipboard_text_config.rasi"

selection=$(cliphist list | grep -v '\[\[ binary data' | sed 's/^[0-9]\+[[:space:]]\+//' | rofi -dmenu -theme "$ROFI_THEME")

if [ -n "$selection" ]; then
    CLIP_ID=$(cliphist list | grep -v '\[\[ binary data' | grep -F -m 1 "$selection" | awk '{print $1}')
    if [ -n "$CLIP_ID" ]; then
        cliphist decode "$CLIP_ID" | wl-copy
        wtype -M ctrl -k v -m ctrl
    fi
fi
