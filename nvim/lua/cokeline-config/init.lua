-- local get_hex = require("cokeline.utils").get_hl_attr
local get_hex = require("cokeline.hlgroups").get_hl_attr
local active_bg_color = '#e0af68'
local inactive_bg_color = get_hex('Normal', 'bg')
local bg_color = get_hex('ColorColumn', 'bg')
local is_picking_focus = require('cokeline/mappings').is_picking_focus
local is_picking_close = require('cokeline/mappings').is_picking_close

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3
require('cokeline').setup({
  show_if_buffers_are_at_least = 1,
  mappings = {
    cycle_prev_next = true
  },
  default_hl = {
    bg = function(buffer)
      if buffer.is_focused then
        return active_bg_color
      end
    end,
  },
  sidebar = {
    filetype = {'NvimTree', 'neo-tree'},
    components = {
      {
        text = function(buf)
          return buf.filetype
        end,
        fg = yellow,
        bg = function() return get_hex('Normal', 'bg') end,
        bold = true,
      },
    },
  },
  components = {
    {
      text = function(buffer)
        local _text = ''
        if buffer.index > 1 then _text = ' ' end
        if buffer.is_focused or buffer.is_first then
          _text = _text .. ''
        end
        return _text
      end,
      fg = function(buffer)
        if buffer.is_focused then
          return active_bg_color
        elseif buffer.is_first then
          return inactive_bg_color
        end
      end,
      bg = function(buffer)
        if buffer.is_focused then
          if buffer.is_first then
            return bg_color
          else
            return inactive_bg_color
          end
        elseif buffer.is_first then
          return bg_color
        end
      end
    },
    {
      text = function(buffer)
        return (is_picking_focus() or is_picking_close())
            and '(' .. buffer.pick_letter .. ')'
            or ''
      end,
      fg = function(buffer)
        return (is_picking_focus() and yellow)
            or (is_picking_close() and red)
            or buffer.devicon.color
      end,
      style = function(_)
        return (is_picking_focus() or is_picking_close())
            and 'italic,bold'
            or nil
      end,
    },
    {
      text = function(buffer)
        local status = ''
        if buffer.is_readonly then
          status = '➖'
        elseif buffer.is_modified then
          status = '✎'
        end
        return status
      end,
    },
    {
      text = function(buffer)
        return " " .. buffer.devicon.icon
      end,
      fg = function(buffer)
        if buffer.is_focused then
          return buffer.devicon.color
        end
      end
    },
    {
      text = function(buffer)
        return buffer.unique_prefix .. buffer.filename
      end,
      fg = function(buffer)
        if buffer.is_focused then
          return '#040404'
        else
          return '#a5a2a2'
        end
      end,
      style = function(buffer)
        local text_style = 'NONE'
        if buffer.is_focused then
          text_style = 'bold'
        end
        if buffer.diagnostics.errors > 0 then
          if text_style ~= 'NONE' then
            text_style = text_style .. ',underline'
          else
            text_style = 'underline'
          end
        end
        return text_style
      end
    },
    {
      text = function(buffer)
        local errors = buffer.diagnostics.errors
        if (errors <= 1) then
          errors = ' '
        else
          errors = " "
        end
        return errors .. ' '
      end,
      fg = function(buffer)
        if buffer.diagnostics.errors == 0 then
          return '#3DEB63'
        elseif buffer.diagnostics.errors >= 1 then
          return '#DB121B'
        end
      end
    },
    {
      text = '  ',
      fg = function(buffer)
        if buffer.is_focused then
          return '#040404'
        end
      end,
      delete_buffer_on_left_click = true
    },
    {
      text = function(buffer)
        if buffer.is_focused or buffer.is_last then
          return ''
        else
          return ' '
        end
      end,
      fg = function(buffer)
        if buffer.is_focused then
          return active_bg_color
        elseif buffer.is_last then
          return inactive_bg_color
        else
          return bg_color
        end
      end,
      bg = function(buffer)
        if buffer.is_focused then
          if buffer.is_last then
            return bg_color
          else
            return inactive_bg_color
          end
        elseif buffer.is_last then
          return bg_color
        end
      end
    }
  },
})
