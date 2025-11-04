return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true, -- close Neo-tree if it's the last window
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,

			filesystem = {
				filtered_items = {
					hide_dotfiles = false, -- show dotfiles
					hide_gitignored = true,
				},
				follow_current_file = { enabled = true }, -- focus on current file
				hijack_netrw_behavior = "open_default",
				window = {
					position = "right",
					width = 35,
					mappings = {
						["<space>"] = "toggle_node",
						["s"] = "toggle_preview", -- press P to preview
						["l"] = "open",     -- open file
						["h"] = "close_node", -- close folder
						["q"] = "close_window",
					},
				},
			},

			-- Shift + L → move to the right window
			-- vim.keymap.set("n", "<S-l>", "<C-w>l", { desc = "Move to right window" }),

			-- Shift + H → move to the left window
			-- vim.keymap.set("n", "<S-h>", "<C-w>h", { desc = "Move to left window" }),
			vim.keymap.set("n", "<leader>n", ":vsplit<CR>"),

			-- vim.keymap.set("n", "<C-Left>", "<C-w>h", { desc = "Move to left split" }),
			-- vim.keymap.set("n", "<C-Right>", "<C-w>l", { desc = "Move to right split" }),

			vim.keymap.set("n", "<C-h>", "<C-w>h"),
			vim.keymap.set("n", "<C-j>", "<C-w>j"),
			vim.keymap.set("n", "<C-k>", "<C-w>k"),
			vim.keymap.set("n", "<C-l>", "<C-w>l"),


			default_component_configs = {
				file_preview = {
					position = "float", -- or "float"
					size = 60,
				},
			},
		})
	end,
}
