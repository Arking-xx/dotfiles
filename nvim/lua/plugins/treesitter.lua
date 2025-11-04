return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" }, -- Add textobjects dependency
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "lua", "vim", "javascript", "html", "css", "embedded_template", "html", "css", "tsx" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
				matchup = { enable = true },
				textobjects = {
					select = {
						enable = true,
						lookahead = true,   -- Automatically jump to matching pair
						keymaps = {
							["ab"] = "@block.outer", -- Select outer block (e.g., <div>...</div>)
							["ib"] = "@block.inner", -- Select inner block (content between tags)
						},
					},
					move = {
						enable = true,
						set_jumps = true,   -- Add to jumplist for navigation
						goto_next_start = {
							["]b"] = "@block.outer", -- Jump to next block start
						},
						goto_previous_start = {
							["[b"] = "@block.outer", -- Jump to previous block start
						},
					},
				},
			})
		end,
	},
}
