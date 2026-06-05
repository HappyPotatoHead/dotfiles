-- Appearance

hl.config({
	general = {
		gaps_in = 2,
		gaps_out = 15,

		-- border_size = 2
		border_size = 2,

		col = {
			active_border = "rgba(fffcf0ff)",
			inactive_border = "rgba(575653ff)",
		},

		--  Set to true enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		--  Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "dwindle",
		snap = {
			enabled = true,
			window_gap = 10,
			monitor_gap = 10,
			border_overlap = false,
		},
	},
	decoration = {
		-- Borders
		rounding = 6,
		-- rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 0.9,
		inactive_opacity = 0.6,

		shadow = {
			enabled = false,
			range = 4,
			render_power = 3,
			color = 0x1a1a1aee,
		},

		-- https://wiki.hypr.land/Configuring/Variables/#blur
		blur = {
			enabled = true,
			size = 10,
			passes = 2,
			new_optimizations = true,
			ignore_opacity = true,
			noise = 0,
			brightness = 0.90,
		},
	},
	cursor = {
		no_warps = true,
		inactive_timeout = 3,
	},
})
