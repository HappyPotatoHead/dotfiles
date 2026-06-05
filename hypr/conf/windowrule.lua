-- See https://wiki.hypr.land/Configuring/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

hl.window_rule({
	name = "resize-floats",
	match = {
		float = true,
	},
	size = {
		"window_w * 0.7",
		"window_h * 0.7",
	},
	center = true,
})

-- # Ignore maximize requests from apps. You'll probably like this.
hl.window_rule({
	match = { class = ".*" },
	suppress_event = "maximize",
})

--
-- # Fix some dragging issues with XWayland
hl.window_rule({
	name = "fix-wayland-drag",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "override-opacity",
	match = {
		class = "firefox",
		"obsidian",
		"code",
	},
	-- Set opacity to 1.0 active, 0.2 inactive and 0.8 fullscreen
	opacity = "1.0 override 0.6 override 1.0 override",
})

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})
