#~/bin/bash

WAYBAR_PROCESS="waybar"

if pgrep -x "$WAYBAR_PROCESS" >/dev/null; then
  killall "$WAYBAR_PROCESS"
else
  exec "$WAYBAR_PROCESS"
fi
