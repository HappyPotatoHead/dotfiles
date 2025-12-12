#!/usr/bin/env bash

ROFI_THEME="~/.config/rofi/clipboard_image_config.rasi"
THUMB_DIR="/tmp/rofi_cliphist_thumbs"
THUMB_SIZE="512x512"

mkdir -p "$THUMB_DIR"

read -r -d '' prog <<EOF

/^[0-9]+\s+\\[\\[ binary data/ {
    id = \$1
    img = "$THUMB_DIR/" id ".png"
    
    cmd = "[ ! -f " img " ] && cliphist decode " id " | convert - -resize $THUMB_SIZE " img
    system(cmd)
    
    printf "\0icon\x1f%s\n", img
    next
}

{ 
    print substr(\$0, index(\$0, " ") + 1)
}
EOF

selection="$(cliphist list | grep '\[\[ binary data' | awk "$prog" | rofi -dmenu -theme "$ROFI_THEME" -show-icons -format 'i')"

if [ -n "$selection" ]; then
  LINE_NUMBER=$((selection + 1))
  FULL_LINE=$(cliphist list | grep '\[\[ binary data' | head -n "$LINE_NUMBER" | tail -n 1)
  CLIP_ID=$(echo "$FULL_LINE" | awk '{print $1}')
  if [ -n "$CLIP_ID" ]; then
    cliphist decode "$CLIP_ID" | wl-copy
  fi
  # echo "$selection" | cliphist decode | wl-copy
fi
