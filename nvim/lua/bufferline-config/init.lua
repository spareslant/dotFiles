require('bufferline').setup {
    options = {
        offsets = {
            {filetype = "NvimTree", text = "File Explorer", text_align = "left"}
        },
        separator_style = "thick",
        always_show_bufferline = true,
        indicator = {
          style = "underline",
        },
        color_icons = true,
    }
}
