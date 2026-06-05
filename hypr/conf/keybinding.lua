-- Exiting hyperland
hl.bind(mainMod .. " + escape", hl.dsp.exec_cmd("~/.config/rofi/scripts/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Handing windows
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))

-- Opening applications
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(firefox))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_waybar.sh"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("kitty -e cmus"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("eww open --toggle music && eww open --toggle music1"))

-- Screenshots
-- Standard screenshot (select area)
hl.bind(
	"PRINT",
	hl.dsp.exec_cmd(
		[[grim -g "$(slurp)" -t png - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/screenshot-$(date '+%Y%m%d-%H%M%S').png]]
	)
)

-- Fullscreen screenshot with notification
hl.bind(
	"SHIFT + PRINT",
	hl.dsp.exec_cmd(
		[[sh -c 'grim ~/Pictures/Screenshots/screenshot-$(date '+%Y%m%d-%H%M%S').png && notify-send "Screenshot Saved" "Full screen saved to Screenshots folder."']]
	)
)

-- Area screenshot (Windows style shortcut)
hl.bind(
	mainMod .. " + SHIFT + S",
	hl.dsp.exec_cmd(
		[[grim -g "$(slurp)" -t png - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/screenshot-$(date '+%Y%m%d-%H%M%S').png]]
	)
)

-- OCR (Optical Character Recognition) to clipboard
hl.bind(
	mainMod .. " + SHIFT + T",
	hl.dsp.exec_cmd(
		[[sh -c 'grim -g "$(slurp)" - | tesseract - - -l eng | wl-copy && notify-send "OCR Complete" "Text copied to clipboard"']]
	)
)

-- clipboard
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/rofi/scripts/cliphistory_text.sh"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("~/.config/rofi/scripts/cliphistory_image.sh"))

-- Wallpaper
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/rofi/scripts/wallpaper_switcher.sh"))

-- Emoji
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("rofi -modi emoji -show emoji"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

--  Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

--  Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Move
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))

-- hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

	hl.bind("escape", hl.dsp.submap("reset"))
	hl.bind("return", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Requires kanshi
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("kanshictl switch lid-closed"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("kanshictl switch both"), { locked = true })
