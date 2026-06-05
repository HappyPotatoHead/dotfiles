#!/usr/bin/sh
# =============================================================
# Author: gh0stzk
# Repo:   https://github.com/gh0stzk/dotfiles
# Date:   24.04.2025
# Info:   This script uses playerctl and mpc to control the multimedia playback
#         "stop, pause, play, next, previous" of different players like
#         spotify, ncmpcpp, clementine, strawberry and others.
# =============================================================

# Set the player
# playerctl --player=firefox status >/dev/null 2>&1 && Control="firefox" || Control="MPD"
# [ -n "$(pgrep spotify)" ] && Control="spotify" || Control="MPD"
Control=$(playerctl -l 2>/dev/null | grep -m1 '^firefox')
[ -z "$Control" ] && Control="MPD"

# Here the cover image will be saved.
Cover=/tmp/cover.png
# if cover not found in metadata use this instead
bkpCover=~/.config/bspwm/src/assets/fallback.webp
# mpd music directory for mpd clients.
mpddir=~/Music
LAST_SONG_FILE="/tmp/last_song.txt"

case $Control in
MPD)
    case $1 in
    --next)
        mpc -q next
        ;;
    --previous)
        mpc -q prev
        ;;
    --toggle)
        mpc -q toggle
        ;;
    --stop)
        mpc -q stop
        ;;
    --title)
        title=$(mpc -f %title% current)
        echo "${title:-Play Something}"
        ;;
    --artist)
        artist=$(mpc -f %artist% current)
        echo "${artist:-No Artist}"
        ;;
    --status)
        status=$(mpc status | sed -En '2s/.*\[([^]]*)\].*/\u\1/p')
        echo "${status:-Stopped}"
        ;;
    --player)
        echo "$Control"
        ;;
    --cover)
        current_song=$(mpc current -f "%title%-%artist%")
        last_song=""
        [ -f "$LAST_SONG_FILE" ] && last_song=$(cat "$LAST_SONG_FILE")

        if [ "$current_song" != "$last_song" ] || [ ! -f "$Cover" ]; then
            ffmpeg -i "$mpddir/$(mpc current -f %file%)" "$Cover" -y >/dev/null 2>&1 || cp "$bkpCover" "$Cover"
            echo "$current_song" >"$LAST_SONG_FILE"
        fi

        echo "$Cover"
        ;;
    nccover)
        ffmpeg -i "$mpddir/$(mpc current -f %file%)" "$Cover" -y >/dev/null 2>&1 || cp "$bkpCover" "$Cover"
        ;;
    --position)
        position=$(mpc status %currenttime%)
        echo "${position:-0:00}"
        ;;
    --positions)
        positions=$(mpc status %currenttime% | awk -F: '{print ($1 * 60) + $2}')
        echo "${positions:-0}"
        ;;
    --length)
        length=$(mpc status %totaltime%)
        echo "${length:-0:00}"
        ;;
    --lengths)
        lengths=$(mpc status %totaltime% | awk -F: '{print ($1 * 60) + $2}')
        echo "${lengths:-0}"
        ;;
    esac
    ;;
*)
    case $1 in
    --next)
        playerctl --player="$Control" next
        ;;
    --previous)
        playerctl --player="$Control" previous
        ;;
    --toggle)
        playerctl --player="$Control" play-pause
        ;;
    --stop)
        playerctl --player="$Control" stop
        ;;
    --title)
        title=$(playerctl --player="$Control" metadata --format "{{title}}")
        echo "${title:-Play Something}"
        ;;
    --artist)
        artist=$(playerctl --player="$Control" metadata --format "{{artist}}")
        echo "${artist:-No Artist}"
        ;;
    --status)
        status=$(playerctl --player="$Control" status)
        echo "${status:-Stopped}"
        ;;
    --player)
        echo "$Control"
        ;;
    --cover)
        CACHE_DIR="$HOME/.cache/eww/music-covers"
        mkdir -p "$CACHE_DIR"

        track_url=$(playerctl --player="$Control" metadata xesam:url 2>/dev/null)

        video_id=$(printf "%s\n" "$track_url" | sed -n 's/.*[?&]v=\([^&]*\).*/\1/p')

        if [ -z "$video_id" ]; then
            echo "$bkpCover"
            exit 0
        fi

        cover_file="$CACHE_DIR/$video_id.jpg"
        thumb_url="https://img.youtube.com/vi/$video_id/hqdefault.jpg"

        if [ ! -s "$cover_file" ]; then
            curl -s -L --max-time 5 "$thumb_url" -o "$cover_file"
        fi

        if [ -s "$cover_file" ]; then
            echo "$cover_file"
        else
            echo "$bkpCover"
        fi
        ;;
    --position)
        position=$(playerctl --player="$Control" position --format "{{ duration(position) }}")
        echo "${position:-0:00}"
        ;;
    --positions)
        positions=$(playerctl --player="$Control" position 2>/dev/null | awk '{print int($1)}')
        echo "${positions:-0}"
        ;;
    --length)
        length=$(playerctl --player="$Control" metadata --format "{{ duration(mpris:length) }}")
        echo "${length:-0:00}"
        ;;
    --lengths)
        lengths=$(playerctl --player="$Control" metadata mpris:length 2>/dev/null | awk '{print int($1 / 1000000)}')
        echo "${lengths:-0}"
        ;;
    esac
    ;;
esac 2>/dev/null
