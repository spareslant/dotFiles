local fn = vim.fn
fn.execute("highlight NnnBorder guifg=#555555")

local builtin = require("nnn").builtin

function builtin.mycd_to_path(files)
	-- local dir = files[1]:match(".*/")
	local dir = files[1]
  print("MY-DEBUG => "..dir)
	local read = io.open(dir, "r")

	if read ~= nil then
		io.close(read)
		fn.execute("cd "..dir)
		vim.defer_fn(function() print("working directory changed to: "..dir) end, 0)
	end
end

require("nnn").setup({
	picker = {
    cmd = "nnn -d -G",
		style = { border = "rounded" },
	},
	mappings = {
		{ "<C-t>", builtin.open_in_tab }, -- open file(s) in tab
		{ "<C-s>", builtin.open_in_split }, -- open file(s) in split
		{ "<C-v>", builtin.open_in_vsplit }, -- open file(s) in vertical split
		{ "<C-p>", builtin.open_in_preview }, -- open file in preview split keeping nnn focused
		{ "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
		{ "<C-i>", builtin.mycd_to_path }, -- cd to file directory
		{ "<C-e>", builtin.populate_cmdline }, -- populate cmdline (:) with file(s)
	},
})
