mainMod = "SUPER"
terminal = "kitty"
fileManager = "dolphin"
menu =
firefox = "firefox"
waybar = "waybar"

hl.layer_rule({
	match = { namespace = "^(rofi)$" },
	no_anim = true,
})

hl.monitor({
	output = "",
	mode = "",
	position = "auto",
	scale = "1",
})

require("conf/autostart")
require("conf/environment")
require("conf/appearance")
require("conf/animation")
require("conf/misc")
require("conf/input")
require("conf/keybinding")
require("conf/windowrule")
require("conf/layout")
