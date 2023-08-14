local bufferline = require("bufferline")
return {
    options = {
        mode = "buffers",
        style_preset = bufferline.style_preset.no_italic, -- Or bufferline.style_preset.minimal,
        themable = true, -- Allows highlight groups to be overriden i.e. sets highlights as default
        diagnostics = "nvim_lsp",
        color_icons = true,
        show_buffer_icons = false,
        offsets = {
            {
                filetype = "NvimTree",
                text = "NvimTree",
                highlight = "Directory",
                text_align = "center",
            }
        },
    }
}
