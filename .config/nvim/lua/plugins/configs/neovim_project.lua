local mapping_neovim_project = require("core.mappings").plugins.neovim_project()

return {
	projects = {
		"~/Documents/projects/*",
		"~/Documents/works/*",
		"~/Documents/works/senso/*",
		"~/.config/*",
	},
	picker = {
		type = "telescope",
	},
	last_session_on_startup = false,
	forget_project_keys = mapping_neovim_project,
}
