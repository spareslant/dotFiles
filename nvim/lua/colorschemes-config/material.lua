vim.g.material_style = "darker"
-- vim.g.material_style = "oceanic"
vim.cmd("colorscheme material")

require("lualine").setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    theme = "material-nvim",
  },
})
