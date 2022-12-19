local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
vim.g.mapleader = " "

-- barbar key mappings
-- nvim_tree_toggle = require("barbar-config.tree")
-- map("n", "<A-e>", "<cmd> lua nvim_tree_toggle()<CR>", opts)
-- -- Move to previous/next
-- map("n", "<A-,>", ":BufferPrevious<CR>", opts)
-- map("n", "<A-.>", ":BufferNext<CR>", opts)
-- -- Re-order to previous/next
-- map("n", "<A-<>", ":BufferMovePrevious<CR>", opts)
-- map("n", "<A->>", " :BufferMoveNext<CR>", opts)
-- -- Goto buffer in position...
-- map("n", "<A-1>", ":BufferGoto 1<CR>", opts)
-- map("n", "<A-2>", ":BufferGoto 2<CR>", opts)
-- map("n", "<A-3>", ":BufferGoto 3<CR>", opts)
-- map("n", "<A-4>", ":BufferGoto 4<CR>", opts)
-- map("n", "<A-5>", ":BufferGoto 5<CR>", opts)
-- map("n", "<A-6>", ":BufferGoto 6<CR>", opts)
-- map("n", "<A-7>", ":BufferGoto 7<CR>", opts)
-- map("n", "<A-8>", ":BufferGoto 8<CR>", opts)
-- map("n", "<A-9>", ":BufferGoto 9<CR>", opts)
-- map("n", "<A-0>", ":BufferLast<CR>", opts)
-- -- Close buffer
-- map("n", "<A-c>", ":BufferClose<CR>", opts)
-- -- Magic buffer-picking mode
-- map("n", "<C-p>", ":BufferPick<CR>", opts)
-- -- Sort automatically by...
-- map("n", "<Space>bb", ":BufferOrderByBufferNumber<CR>", opts)
-- map("n", "<Space>bd", ":BufferOrderByDirectory<CR>", opts)
-- map("n", "<Space>bl", ":BufferOrderByLanguage<CR>", opts)

-- cokeline key mappings
cokeline_mappings = require("cokeline/mappings")
nvim_tree_toggle = require("cokeline-config.tree")
close_current_buffer = require('bufdelete').bufdelete
map("n", "<A-e>", "<cmd>lua nvim_tree_toggle()<CR>", opts)
map("n", "<A-,>", "<Cmd>lua cokeline_mappings.by_step('focus', -1)<CR>", opts)
map("n", "<A-.>", "<Cmd>lua cokeline_mappings.by_step('focus', 1)<CR>", opts)
map("n", "<A-f>", "<Cmd>lua cokeline_mappings.pick('focus')<CR>", opts)
-- map("n", "<A-c>", "<Cmd>lua cokeline_mappings.pick('close')<CR>", opts)
map("n", "<A-c>", "<Cmd>lua close_current_buffer(0, true)<CR>", opts)

-- Telescope mappings
map("n", "<leader>tt", ":Telescope<CR>", opts)
map("n", "<leader>tf", ":Telescope find_files<CR>", opts)
map("n", "<leader>tg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>tb", ":Telescope buffers<CR>", opts)
map("n", "<leader>tr", ":Telescope resume<CR>", opts)

-- Floatterm mappings
-- Note: <C-\><C-n> is <ESC>, in neovim config, '\' needed escape, therefore <C-\> becomes <C-\\>
-- https://github.com/neovim/neovim/issues/7648
-- vim windows commands will also be functioning. e.g Go to NORMAL mode in pop-up terminal by pressing
-- <C-\><C-n>. Now you can press <C-w>H to move window to extreme left
map("n", "<C-\\>c", ":FloatermNew<CR>", opts)
map("t", "<C-\\>c", "<C-\\><C-n>:FloatermNew<CR>", opts)
map("n", "<C-\\>t", ":FloatermToggle<CR>", opts)
map("t", "<C-\\>t", "<C-\\><C-n>:FloatermToggle<CR>", opts)
map("n", "<C-\\>n", ":FloatermNext<CR>", opts)
map("t", "<C-\\>n", "<C-\\><C-n>:FloatermNext<CR>", opts)
map("n", "<C-\\>z", ":FloatermUpdate --height=0.95 --width=0.95<CR>", opts)
map("t", "<C-\\>z", "<C-\\><C-n>:FloatermUpdate --height=0.95 --width=0.95<CR>", opts)
map("n", "<C-\\>s", ":FloatermUpdate --height=0.6 --width=0.6<CR>", opts)
map("t", "<C-\\>s", "<C-\\><C-n>:FloatermUpdate --height=0.6 --width=0.6<CR>", opts)
map("n", "<C-\\>j", ":FloatermUpdate --wintype=split --position=rightbelow --height=0.3<CR>", opts)
map("t", "<C-\\>j", "<C-\\><C-n>:FloatermUpdate --wintype=split --position=rightbelow --height=0.3<CR>", opts)
map("n", "<C-\\>l", ":FloatermUpdate --wintype=vsplit --position=rightbelow --width=0.4<CR>", opts)
map("t", "<C-\\>l", "<C-\\><C-n>:FloatermUpdate --wintype=vsplit --position=rightbelow --width=0.4<CR>", opts)
map("n", "<C-\\>h", ":FloatermUpdate --wintype=vsplit --position=leftabove --width=0.4<CR>", opts)
map("t", "<C-\\>h", "<C-\\><C-n>:FloatermUpdate --wintype=vsplit --position=leftabove --width=0.4<CR>", opts)
map("n", "<C-\\>f", ":FloatermUpdate --wintype=float --height=0.6 --width=0.6 --position=center<CR>", opts)
map("t", "<C-\\>f", "<C-\\><C-n>:FloatermUpdate --wintype=float --height=0.6 --width=0.4 --position=center<CR>", opts)

-- Trouble mapping
map("n", "<leader>xx", "<cmd>Trouble<cr>", opts)
map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)
map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)
map("n", "<leader>xr", "<cmd>Trouble lsp_references<cr>", opts)

-- Null-ls mapping
map("n", "<leader>nf", "<cmd>lua vim.lsp.buf.format { async = true }<cr>", opts)

-- nnn mappings
map("n", "<leader>nn", "<cmd>NnnExplorer %:p:h<cr>", opts)
map("t", "<leader>nn", "<cmd>NnnExplorer %:p:h<cr>", opts)
map("n", "<leader>np", "<cmd>NnnPicker %:p:h<cr>", opts)
map("t", "<leader>np", "<cmd>NnnPicker %:p:h<cr>", opts)

-- lazigit mapping
map("n", "<leader>lg", "<cmd>LazyGit<cr>", opts)

-- toggle-lsp-diag
map("n", "<leader>tld", "<cmd>ToggleDiag<cr>", opts)

-- start lspsaga mapping ----------------------------------------------------
map("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
map("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
map("n", "gr", "<cmd>Lspsaga rename<CR>", { silent = true })
-- support tagstack C-t jump back
map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
map("n", "<leader>ld", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
map("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
-- Diagnsotic jump can use `<c-o>` to jump back
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
-- Only jump to error
lspsaga_diag = function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end
map("n", "[E", "<cmd>lua lspsaga_diag()<CR>", { silent = true })
lspsaga_diag_next = function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end
map("n", "]E", "<cmd>lua lspsaga_diag_next()<CR>", { silent = true })
map("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })
map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- stop lspsaga mapping ----------------------------------------------------
