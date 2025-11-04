return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>" },
	},
	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = { "node_modules", ".git/" },
			},
			pickers = {
				find_files = {
					theme = "dropdown",
				},
			},
		})
	end,
}
