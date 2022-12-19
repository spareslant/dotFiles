local nvim_tree_toggle = function()
  local view = require("nvim-tree.view")
  -- local lib = require("nvim-tree.lib")

  local open = function()
    require("bufferline.state").set_offset(31, "FileTree")
    require("nvim-tree.api").tree.toggle()
  end

  local close = function()
    require("bufferline.state").set_offset(0)
    view.close()
  end

  if view.is_visible() then
    close()
  else
    open()
  end
end

return nvim_tree_toggle
