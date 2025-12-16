require("core.mappings").plugins.neo_tree()

return {
	window = {
		mappings = {
			["t"] = "open",
			["<CR>"] = "open",
		},
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
		},
	},
	default_component_configs = {
		icon = {
			provider = function(icon, node)
				local text, hl
				local mini_icons = require("mini.icons")
				if node.type == "file" then
					text, hl = mini_icons.get("file", node.name)
				elseif node.type == "directory" then
					text, hl = mini_icons.get("directory", node.name)
					if node:is_expanded() then
						text = nil
					end
				end

				if text then
					icon.text = text
				end
				if hl then
					icon.highlight = hl
				end
			end,
		},
		kind_icon = {
			provider = function(icon, node)
				icon.text, icon.highlight = require("mini.icons").get("lsp", node.extra.kind.name)
			end,
		},
	},
}
