local mapping_telescope, mapping_file_browser = require("core.mappings").plugins.telescope()
local buffer_dir = require("telescope.utils").buffer_dir

return {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "-L",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        mappings = mapping_telescope,
        sorting_strategy = "ascending",
        file_ignore_patterns = { "^.git/" },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
    },
    pickers = {
        find_files = {
            cwd = buffer_dir(),
            hidden = true,
        },
        live_grep = {
            cwd = buffer_dir(),
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,                   -- False will only do exact matching
            override_generic_sorter = true, -- Override the generic sorter
            override_file_sorter = true,    -- Override the file sorter
            case_mode = "smart_case",       -- Or "ignore_case" or "respect_case"
        },
        file_browser = {
            -- Disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = mapping_file_browser,
            depth = 3,
        },
    }
}
