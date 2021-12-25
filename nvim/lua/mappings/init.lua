local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)

-- barbar key mapping
-- Move to previous/next
map('n', '<A-,>', ':BufferLineCyclePrev<CR>', opts)
map('n', '<A-.>', ':BufferLineCycleNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', ':BufferLineMovePrev<CR>', opts)
map('n', '<A->>', ' :BufferLineMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferLineGotoBuffer 1<CR>', opts)
map('n', '<A-2>', ':BufferLineGotoBuffer 2<CR>', opts)
map('n', '<A-3>', ':BufferLineGotoBuffer 3<CR>', opts)
map('n', '<A-4>', ':BufferLineGotoBuffer 4<CR>', opts)
map('n', '<A-5>', ':BufferLineGotoBuffer 5<CR>', opts)
map('n', '<A-6>', ':BufferLineGotoBuffer 6<CR>', opts)
map('n', '<A-7>', ':BufferLineGotoBuffer 7<CR>', opts)
map('n', '<A-8>', ':BufferLineGotoBuffer 8<CR>', opts)
map('n', '<A-9>', ':BufferLineGotoBuffer 9<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferLinePickClose<CR>', opts)
map('n', '<A-p>', ':BufferLinePick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bd', ':BufferLineSortByDirectory<CR>', opts)

-- Telescope mappings 
map('n', '<leader>tf', ':Telescope find_files<CR>', opts)
map('n', '<leader>tg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>tb', ':Telescope buffers<CR>', opts)
map('n', '<leader>tr', ':Telescope resume<CR>', opts)
