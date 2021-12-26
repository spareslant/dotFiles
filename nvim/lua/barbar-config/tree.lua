nvim_tree_toggle = function()
	open = function()
		require("bufferline.state").set_offset(31, "FileTree")
		require("nvim-tree").find_file(true)
	end

	close = function()
		require("bufferline.state").set_offset(0)
		require("nvim-tree").close()
	end

	local view = require("nvim-tree.view")
	local lib = require("nvim-tree.lib")

	if view.win_open() then
		close()
	else
		open()
	end
end

return nvim_tree_toggle
