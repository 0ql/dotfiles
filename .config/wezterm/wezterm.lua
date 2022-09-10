local wezterm = require 'wezterm'

return {
	default_prog = { '/bin/zsh' },
	font_rules = {
		-- Define a rule => that matches when italic text is shown
		-- {
		-- 	italic = false,
		-- 	font = wezterm.font_with_fallback {
		-- 		'Monocraft',
		-- 		'Symbols Nerd Font Mono'
		-- 	},
		-- 	-- freetype_load_target = "Mono",
		-- },
		{
			italic = true,
			font = wezterm.font_with_fallback {
				'Fira Code',
				'Symbols Nerd Font Mono'
			},
		},
	},
	freetype_load_target = "Normal",
	font_size = 17.0,
	color_scheme = 'Gruvbox Dark',
	window_background_opacity = 0,
	window_decorations = "NONE",
	enable_tab_bar = false,
	line_height = 1.1,
	cell_width = 1.0,
	default_cursor_style = "SteadyBar"
}
