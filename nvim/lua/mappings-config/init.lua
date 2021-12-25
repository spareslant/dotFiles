local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

-- map('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
nvim_tree_toggle = require('barbar-config.tree')
map('n', '<A-e>', '<cmd> lua nvim_tree_toggle()<CR>', opts)

-- barbar key mapping
-- Move to previous/next
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>', opts)
-- Magic buffer-picking mode
map('n', '<C-p>', ':BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)
-- Telescope mappings 
map('n', '<leader>tf', ':Telescope find_files<CR>', opts)
map('n', '<leader>tg', ':Telescope live_grep<CR>', opts)
map('n', '<leader>tb', ':Telescope buffers<CR>', opts)
map('n', '<leader>tr', ':Telescope resume<CR>', opts)

-- Floatterm mappings
-- Note: <C-\><C-n> is <ESC>, in neovim config, '\' needed escape, therefore <C-\> becomes <C-\\>
-- https://github.com/neovim/neovim/issues/7648
map('n', '<C-\\>n', ':FloatermNew<CR>', opts)
map('t', '<C-\\>n', '<C-\\><C-n>:FloatermNew<CR>', opts)
map('n', '<C-\\>t', ':FloatermToggle<CR>', opts)
map('t', '<C-\\>t', '<C-\\><C-n>:FloatermToggle<CR>', opts)
map('n', '<C-\\>r', ':FloatermNext<CR>', opts)
map('t', '<C-\\>r', '<C-\\><C-n>:FloatermNext<CR>', opts)
map('n', '<C-\\>l', ':FloatermUpdate --height=0.95 --width=0.95<CR>', opts)
map('t', '<C-\\>l', '<C-\\><C-n>:FloatermUpdate --height=0.95 --width=0.95<CR>', opts)
map('n', '<C-\\>s', ':FloatermUpdate --height=0.6 --width=0.6<CR>', opts)
map('t', '<C-\\>s', '<C-\\><C-n>:FloatermUpdate --height=0.6 --width=0.6<CR>', opts)
map('n', '<C-\\>h', ':FloatermUpdate --wintype=split<CR>', opts)
map('t', '<C-\\>h', '<C-\\><C-n>:FloatermUpdate --wintype=split --height=0.3<CR>', opts)
