local mapping_telescope, mapping_file_browser, mapping_buffers = require("core.mappings").plugins.telescope()

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
		selection_caret = " ",
		entry_prefix = " ",
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		buffers = {
			mappings = mapping_buffers,
			ignore_current_buffer = true,
			sort_mru = true,
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- False will only do exact matching
			override_generic_sorter = true, -- Override the generic sorter
			override_file_sorter = true, -- Override the file sorter
			case_mode = "smart_case", -- Or "ignore_case" or "respect_case"
		},
		file_browser = {
			-- Disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = mapping_file_browser,
			depth = 5,
			respect_gitignore = true,
			display_stat = false,
		},
	},
}
