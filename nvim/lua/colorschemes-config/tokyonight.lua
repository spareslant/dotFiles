-- color selections: https://www.canva.com/colors/color-wheel/
vim.api.nvim_exec([[
augroup MyColors
  autocmd!
  autocmd ColorScheme * highlight LineNr guifg=#5081c0 | highlight CursorLineNR guifg=#FFba00
  autocmd ColorScheme * highlight Search guibg=#fdc17f guifg=#000000
augroup END
]], false)

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.tokyonight_transparent = true

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
vim.g.tokyonight_colors = {
  hint = "#fb90ce",
  comment = "#b39f90",
  gitSigns = { add = "#0af583", change = "#f7cc3a", delete = "#ff1119" },
}
vim.cmd([[
colorscheme tokyonight
]])

require("lualine").setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    theme = "tokyonight",
  },
})
