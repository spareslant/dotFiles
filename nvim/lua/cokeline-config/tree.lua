vim.g.nvimTreeWidth = 30

local nvim_tree_toggle = function()
  local view = require("nvim-tree.view")
  local open = function()
    require("nvim-tree.api").tree.toggle()
  end

  local close = function()
    view.close()
  end

  local get_current_nvimtree_width = function()
    for _, buf in pairs(vim.api.nvim_list_bufs()) do
      if vim.bo[buf].ft == "NvimTree" then
        return vim.fn.winwidth(vim.fn.bufwinid(buf))
      end
    end
  end

  if view.is_visible() then
    vim.g.nvimTreeWidth = get_current_nvimtree_width()
    close()
  else
    view.View.width = vim.g.nvimTreeWidth
    open()
  end
end

return nvim_tree_toggle
