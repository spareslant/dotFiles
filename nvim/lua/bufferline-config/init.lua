require("bufferline").setup({
	options = {
		numbers = function(opts)
			return string.format('%s', opts.id)
		end,
		separator_style = "slant",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left"
			}
		}
	}
})
