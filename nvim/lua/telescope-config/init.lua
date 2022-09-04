-- Below settings are just for trouble.nvim plugin
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

local telescope = require("telescope")

vim.cmd [[
  autocmd User TelescopePreviewerLoaded setlocal wrap
]]

telescope.setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
})
