return {
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { 'stylua' },
					javascript = { 'prettierd', "prettier" },
					typescript = { 'prettierd', "prettier" },
					javascriptreact = { 'prettierd', "prettier" },
					typescriptreact = { 'prettierd', "prettier" },
					html = { 'prettierd', "prettier" },
					css = { 'prettierd', "prettier" },
					json = { 'prettierd', "prettier" },
					markdown = { 'prettierd', "prettier" },
				},
				format_on_save = function(bufnr)
					local max_filesize = 50 * 1024 -- 50 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(bufnr))
					if ok and stats and stats.size > max_filesize then
						return nil
					end
					local bufname = vim.api.nvim_buf_get_name(bufnr)
					if bufname:match("node_modules") or bufname:match("%.min%.") then
						return nil
					end
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
						quiet = true
					}
				end,
				formatters = {
					prettier = {
						prepend_args = function()
							local config_path = vim.fn.expand("~/.prettierrc.json")
							if vim.fn.filereadable(config_path) == 1 then
								return { "--config", config_path }
							end
							return {}
						end,
						args = {
							"--stdin-filepath",
							"$FILENAME",
							"--no-error-on-unmatched-pattern",
						},
						quiet = true,
					},
					prettierd = {
						prepend_args = { "---config", vim.fn.expand("~/.prettierrc.json") },
						quiet = true
					},
					stylua = {
						timeout_ms = 2000,
					},
				},
				default_format_opts = {
					timeout_ms = 2000,
					async = false,
					quiet = true,
				},
				notify_on_error = true,
				notify_no_formatters = false,
			})
			vim.api.nvim_create_user_command("Format", function()
				require("conform").format({ async = true })
			end, { desc = "Format current buffer" })
			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				require("conform").format({
					async = true,
					lsp_fallback = true,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close_on_slash = false
				}
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
				fast_wrap = {
					map = '<M-e>',
					chars = { '{', '[', '(', '"', "'" },
					pattern = [=[[%'%"%)%>%]%)%}%,]]=],
					end_key = '$',
					keys = 'qwertyuiopzxcvbnmasdfghjkl',
					check_comma = true,
					highlight = 'Search',
					highlight_grey = 'Comment'
				},
			})
		end,
	},
}
