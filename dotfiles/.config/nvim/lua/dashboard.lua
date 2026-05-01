-- lua/dashboard.lua
-- Snacks dashboard preset — required by init.lua via require('dashboard').config()

local M = {}

M.config = function()
	return {
		enabled = true,
		preset  = {
			header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
			keys = {
				{ icon = '󰮗 ', key = 'f', desc = 'Find File',    action = ':lua Snacks.picker.files()' },
				{ icon = ' ', key = 'n', desc = 'New File',     action = ':enew | startinsert' },
				{ icon = ' ', key = 'r', desc = 'Recent Files', action = ':lua Snacks.picker.recent()' },
				{ icon = '󰊄 ', key = 'g', desc = 'Grep Text',    action = ':lua Snacks.picker.grep()' },
				{ icon = ' ', key = 'e', desc = 'Explorer',     action = ':lua Snacks.explorer()' },
				{ icon = '󰒲 ', key = 'l', desc = 'Lazy',         action = ':Lazy' },
				{ icon = '󰋗 ', key = '?', desc = 'Cheatsheet',   action = ':lua require("cheatsheet").show()' },
				{ icon = '󰈆 ', key = 'q', desc = 'Quit',         action = ':qa' },
			},
		},
	}
end

return M
