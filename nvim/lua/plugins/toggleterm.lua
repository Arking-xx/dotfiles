return {
	"akinsho/toggleterm.nvim",
	version = "*", -- Use latest stable version
	keys = {
		{ "<leader>t", "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle terminal" },
	},
	config = function()
		require("toggleterm").setup({
			size = 55, -- Terminal height (for horizontal split)
			open_mapping = nil, -- Disable default mapping
			direction = "float", -- Default direction
			close_on_exit = true, -- Close terminal on process exit
			shade_terminals = true, -- Add background shading
		})
	end,
}
