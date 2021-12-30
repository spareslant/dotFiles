-- color selections: https://www.canva.com/colors/color-wheel/
vim.o.background = 'dark'
require("ayu").setup({
	mirage = false,
	overrides = {
		Comment = { fg = "#9e926f" },
		LineNr = { fg = "#5081c0" },
		Visual = { bg = "#5a4e39" },
	},
})
require("ayu").colorscheme()
