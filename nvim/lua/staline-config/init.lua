local git_buffer_add_status = function()
  local added_status = ''
    if vim.b.gitsigns_status ~= nil then
      if vim.b.gitsigns_status_dict['added'] ~= nil then
        added_status = { 'AddedHighLight', '  ' .. vim.b.gitsigns_status_dict['added'] .. ' '}
      end
    end
    return added_status
end

local git_buffer_changed_status = function()
  local changed_status = ''
    if vim.b.gitsigns_status ~= nil then
      if vim.b.gitsigns_status_dict['changed'] ~= nil then
        changed_status = { 'ChangedHighLight', ' 柳' .. vim.b.gitsigns_status_dict['changed'] .. ' ' }
      end
    end
    return changed_status
end

local git_buffer_removed_status = function()
  local removed_status = ''
    if vim.b.gitsigns_status ~= nil then
      if vim.b.gitsigns_status_dict['removed'] ~= nil then
        removed_status = { 'RemovedHighLight', '  ' .. vim.b.gitsigns_status_dict['removed'] .. ' ' }
      end
    end
    return removed_status
end

vim.cmd('highlight AddedHighLight guifg=#000000 guibg=#98c379')
vim.cmd('highlight ChangedHighLight guifg=#000000 guibg=#a9a1e1')
vim.cmd('highlight RemovedHighLight guifg=#000000 guibg=#e86671')

require('staline').setup {
    defaults = {
        expand_null_ls = true,  -- This expands out all the null-ls sources to be shown
        left_separator = "",
        right_separator = "",
        full_path       = false,
        line_column     = "[%l/%L] :%c 並%p%% ", -- `:h stl` to see all flags.

        fg              = "#000000",  -- Foreground text color.
        bg              = "none",     -- Default background is transparent.
        inactive_color  = "#303030",
        inactive_bgcolor = "none",
        true_colors     = true,      -- true lsp colors.
        font_active     = "bold",     -- "bold", "italic", "bold,italic", etc

        mod_symbol      = "  ",
        lsp_client_symbol = " ",
        branch_symbol   = " ",
    },
    mode_icons = {
        n = " ",
        i = " ",
        c = " ",
        v = " ",   -- etc..
    },
    special_table = {
        NvimTree = { 'NvimTree', ' ' },
        packer = { 'Packer',' ' },        -- etc
    },
    lsp_symbols = {
        Error=" ",
        Info=" ",
        Warn=" ",
        Hint="",
    },
    sections = {
      left = {
        '- ', '-mode', 'left_sep', ' ',
        'right_sep', '-file_size', 'left_sep', ' ',
        'branch', git_buffer_add_status, git_buffer_changed_status, git_buffer_removed_status,
      },
      mid  = {'lsp'},
      right= {
        'right_sep', '-cool_symbol', 'left_sep', ' ',
        'right_sep', '- ', '-lsp_name', '- ', 'left_sep', ' ',
        'right_sep', '-line_column',
      }
    },
}
