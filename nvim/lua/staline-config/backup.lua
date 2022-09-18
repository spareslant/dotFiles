local git_buffer_status = function()
		left_separator = ""
		right_separator = ""
    if vim.b.gitsigns_status ~= nil then
      return right_separator .. vim.b.gitsigns_status .. left_separator .. ' '
    end
    return ''
end

require'staline'.setup {

	sections = {
		left = {
			' ', 'right_sep', '-mode', 'left_sep', ' ',
			'right_sep', '-file_name', 'left_sep', ' ',
			'right_sep', '-file_size', 'left_sep', ' ',
			'right_sep', '-branch', 'left_sep', ' ',
		},
		mid  = {'lsp'},
		right= {
			'right_sep', '-cool_symbol', 'left_sep', ' ',
			'right_sep', '- ', '-lsp_name', '- ', 'left_sep', ' ',
			'right_sep', '-line_column', 'left_sep', ' ',
		}
	},

	defaults={
		left_separator = "",
		right_separator = "",
		-- line_column = "%l:%c [%L]",
    fg              = "#000000",  -- Foreground text color.
    bg              = "none",     -- Default background is transparent.
    inactive_color  = "#303030",
    inactive_bgcolor = "none",
		true_colors = true,
		line_column = "[%l:%c] 並%p%% "
		-- font_active = "bold"
	},
  special_table = {
    NvimTree = { 'NvimTree', ' ' },
    packer = { 'Packer',' ' },        -- etc
  },
  lsp_symbols = {
    Error=" ",
    Info=" ",
    Warn=" ",
    Hint="",
  },
}
