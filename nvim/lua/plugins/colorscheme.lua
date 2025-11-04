return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "mocha",
			background = { dark = "mocha" },
			transparent_background = true,

			color_overrides = {
				mocha = {
					-- pure black background
					base = "#000000",
					mantle = "#000000",
					crust = "#000000",
				},
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				notify = false,
				lualine = true,
				matchup = true,
				mini = { enabled = true, indentscope_color = "" },
			},
			custom_highlights = function(colors)
				return {
					Comment = { fg = '#565f89', style = { "italic" } },
					String = { fg = "#a5e6ba", style = { "italic" } },
					Number = { fg = "#e0af68" },
					Function = { fg = "#f7b801", style = { "italic", 'bold' } },
					Identifier = { fg = "#f7b801" },
					Constant = { style = { 'italic' } },
					LineNr = { fg = "#565f89" },
					CursorLineNr = { fg = "#ffffff", style = { "bold" } },


					--- Override
					-- ["@variable"] = { fg = "#0096c7" },
					-- ["@variable.builtin"] = { fg = "#0096c7" },
					-- ["@parameter"] = { fg = "#f7b801" },
					-- ["@property"] = { fg = "#0096c7", style = { 'italic' } },
					["@keyword"] = { fg = "#7678ed" },

				}
			end,
		},
		config = function(_, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
				},
			})
		end,
	},
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_enabled = 1
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
}

-- return {
-- 	{
-- 		"ficcdaf/ashen.nvim",
-- 		priority = 1000,
-- 		opts = {
-- 			style_presets = {
-- 				bold_functions = true,
-- 				italic_comments = true
-- 			},
-- 		},
-- 		config = function(_, opts)
-- 			require("ashen").setup(opts)
-- 			vim.cmd.colorscheme("ashen")
-- 		end,
-- 	},
-- 	{
-- 		"nvim-lualine/lualine.nvim",
-- 		dependencies = { "nvim-tree/nvim-web-devicons" },
-- 		config = function()
-- 			require("lualine").setup({
-- 				options = {
-- 					theme = "catppuccin",
-- 				},
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"andymass/vim-matchup",
-- 		config = function()
-- 			vim.g.matchup_matchparen_enabled = 1
-- 			vim.g.matchup_matchparen_offscreen = { method = "popup" }
-- 		end,
-- 	},
-- }
